function poly = linear_map(F_s,A)


poly = F_s.V*A';
poly = Polyhedron(poly);
poly.minVRep();
end

