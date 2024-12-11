import { useState } from "react";
import "./Table.css"
import Caret from "../Icon/Caret";

const Table = ( { data } ) => {

    const [sort, setSort] = useState({ keyToSort: "created_at", direction: "desc" })

    if (!data || data.length === 0) {
        return <p>No data available</p>;
    }

    // Get the keys for headers dynamically from the first object in the data
    const headers = Object.keys(data[0]);

    function handleHeaderClick(header) {
        setSort({ 
            keyToSort: header, 
            direction: 
                header === sort.keyToSort ? sort.direction === 'asc' ? 'desc' : 'asc' : 'desc'
        })
    }

    function getSortedArray(arrayToSort) {
        if (sort.direction === 'asc') {
            return arrayToSort.sort((a, b) => (a[sort.keyToSort] > b[sort.keyToSort] ? 1 : -1))
        }
        return arrayToSort.sort((a, b) => (a[sort.keyToSort] > b[sort.keyToSort] ? -1 : 1))
    }
    
    return (
        <table border="1" style={{ width: "100%", borderCollapse: "collapse" }}>
          <thead>
            <tr>
              {headers.map((header) => (
                <th key={header} style={{ textAlign: "left", padding: "8px" }} onClick={() => handleHeaderClick(header)}>
                    <div className="header-container">
                        {header.replace(/_/g, " ").toUpperCase()}
                        {header === sort.keyToSort && (
                            <Caret direction={sort.keyToSort === header ? sort.direction : "asc"}></Caret>
                        )}
                    </div>
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {getSortedArray(data).map((item) => (
              <tr key={item.id}>
                {headers.map((header) => (
                  <td key={header} style={{ padding: "8px" }}>
                    {item[header]}
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      );
};

export default Table