Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F38C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 10:58:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24935410ED;
	Wed, 19 Feb 2025 11:58:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9290540E2E
 for <dev@dpdk.org>; Wed, 19 Feb 2025 11:58:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739962718; x=1771498718;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yFVLtlo+veGQz2CSSkuZrVjMsI6rLl5te2ZjGQ+6z5o=;
 b=fbkV+RYG15OTWBpQb0ig734pIs72zQY3BDL7beEdh5zUAnNeEmN8yc5b
 QolFIFuG1Wl9b+gLagi60sKyvD8BhnvhPdBo0AjQloKoMCLz1ggK5yq51
 AkbacM2I5X4zb2XTjUGCn+vFB88EYRI/oQEc43wfeTruzfjdatO32aA2W
 asp8Xfpiqp/TQKSJJhmApao3udRPjW4mXn6SgrnCd0Leq35LvBWiZB1eM
 GhwwMhvxyhVpS7URvViXwEpMuQYFwU//vGisup5S5EtRf1nQKGbQWTtsd
 WRzQArYG9c2P1I9j49/Snz+nWvsPY+t04ijFyztmd8kp+kfGK+M+wANer Q==;
X-CSE-ConnectionGUID: fWCz6i/jTgGNuqhmRYzQag==
X-CSE-MsgGUID: gGZpufBtT7a0naM7H1i/CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44610035"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="44610035"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 02:58:37 -0800
X-CSE-ConnectionGUID: 9SFvDqadRAKe3nM38zhEsg==
X-CSE-MsgGUID: JvpKAijhS5WLcyxh5PWzZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="145533573"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa002.jf.intel.com with ESMTP; 19 Feb 2025 02:58:36 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v7 8/8] devtools: add script to generate DPDK dependency graphs
Date: Wed, 19 Feb 2025 10:57:54 +0000
Message-ID: <169e9b696f26a856ad59012590191c7ce799b175.1739962646.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1739962645.git.anatoly.burakov@intel.com>
References: <cover.1725462264.git.anatoly.burakov@intel.com>
 <cover.1739962645.git.anatoly.burakov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

From: Bruce Richardson <bruce.richardson@intel.com>

Rather than the single monolithic graph that would be output from the
deps.dot file in a build directory, we can post-process that to generate
simpler graphs for different tasks. This new "draw_dependency_graphs"
script takes the "deps.dot" as input and generates an output file that
has the nodes categorized, filtering them based off the requested node or
category. For example, use "--match net/ice" to show the dependency tree
from that driver, or "--match lib" to show just the library dependency
tree.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 devtools/draw-dependency-graphs.py | 223 +++++++++++++++++++++++++++++
 1 file changed, 223 insertions(+)
 create mode 100755 devtools/draw-dependency-graphs.py

diff --git a/devtools/draw-dependency-graphs.py b/devtools/draw-dependency-graphs.py
new file mode 100755
index 0000000000..4fb765498d
--- /dev/null
+++ b/devtools/draw-dependency-graphs.py
@@ -0,0 +1,223 @@
+#! /usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2024 Intel Corporation
+
+import argparse
+import collections
+import sys
+import typing as T
+
+# typedef for dependency data types
+Deps = T.Set[str]
+DepData = T.Dict[str, T.Dict[str, T.Dict[bool, Deps]]]
+
+
+def parse_dep_line(line: str) -> T.Tuple[str, Deps, str, bool]:
+    """Parse digraph line into (component, {dependencies}, type, optional)."""
+    # extract attributes first
+    first, last = line.index("["), line.rindex("]")
+    edge_str, attr_str = line[:first], line[first + 1 : last]
+    # key=value, key=value, ...
+    attrs = {
+        key.strip('" '): value.strip('" ')
+        for attr_kv in attr_str.split(",")
+        for key, value in [attr_kv.strip().split("=", 1)]
+    }
+    # check if edge is defined as dotted line, meaning it's optional
+    optional = "dotted" in attrs.get("style", "")
+    try:
+        component_type = attrs["dpdk_componentType"]
+    except KeyError as _e:
+        raise ValueError(f"Error: missing component type: {line}") from _e
+
+    # now, extract component name and any of its dependencies
+    deps: T.Set[str] = set()
+    try:
+        component, deps_str = edge_str.strip('" ').split("->", 1)
+        component = component.strip().strip('" ')
+        deps_str = deps_str.strip().strip("{}")
+        deps = {d.strip('" ') for d in deps_str.split(",")}
+    except ValueError as _e:
+        component = edge_str.strip('" ')
+
+    return component, deps, component_type, optional
+
+
+def gen_dep_line(component: str, deps: T.Set[str], optional: bool) -> str:
+    """Generate a dependency line for a component."""
+    # we use dotted line to represent optional components
+    attr_str = ' [style="dotted"]' if optional else ""
+    dep_list_str = '", "'.join(deps)
+    deps_str = "" if not deps else f' -> {{ "{dep_list_str}" }}'
+    return f'    "{component}"{deps_str}{attr_str}\n'
+
+
+def read_deps_list(lines: T.List[str]) -> DepData:
+    """Read a list of dependency lines into a dictionary."""
+    deps_data: T.Dict[str, T.Any] = {}
+    for ln in lines:
+        if ln.startswith("digraph") or ln == "}":
+            continue
+
+        component, deps, component_type, optional = parse_dep_line(ln)
+
+        # each component will have two sets of dependencies - required and optional
+        c_dict = deps_data.setdefault(component_type, {}).setdefault(component, {})
+        c_dict[optional] = deps
+    return deps_data
+
+
+def create_classified_graph(deps_data: DepData) -> T.Iterator[str]:
+    """Create a graph of dependencies with components classified by type."""
+    yield "digraph dpdk_dependencies {\n  overlap=false\n  model=subset\n"
+    for n, deps_t in enumerate(deps_data.items()):
+        component_type, component_dict = deps_t
+        yield f'  subgraph cluster_{n} {{\n    label = "{component_type}"\n'
+        for component, optional_d in component_dict.items():
+            for optional, deps in optional_d.items():
+                yield gen_dep_line(component, deps, optional)
+        yield "  }\n"
+    yield "}\n"
+
+
+def parse_match(line: str, dep_data: DepData) -> T.List[str]:
+    """Extract list of components from a category string."""
+    # if this is not a compound string, we have very few valid choices
+    if "/" not in line:
+        # is this a category?
+        if line in dep_data:
+            return list(dep_data[line].keys())
+        # this isn't a category. maybe an app name?
+        maybe_app_name = f"dpdk-{line}"
+        if maybe_app_name in dep_data["app"]:
+            return [maybe_app_name]
+        if maybe_app_name in dep_data["examples"]:
+            return [maybe_app_name]
+        # this isn't an app name either, so just look for component with that name
+        for _, component_dict in dep_data.items():
+            if line in component_dict:
+                return [line]
+        # nothing found still. one last try: maybe it's a driver? we have to be careful though
+        # because a driver name may not be unique, e.g. common/iavf and net/iavf. so, only pick
+        # a driver if we can find exactly one driver that matches.
+        found_drivers: T.List[str] = []
+        for component in dep_data["drivers"].keys():
+            _, drv_name = component.split("_", 1)
+            if drv_name == line:
+                found_drivers.append(component)
+        if len(found_drivers) == 1:
+            return found_drivers
+        # we failed to find anything, report error
+        raise ValueError(f"Error: unknown component: {line}")
+
+    # this is a compound string, so we have to do some matching. we may have two or three levels
+    # of hierarchy, as driver/net/ice and net/ice should both be valid.
+
+    # if there are three levels of hierarchy, this must be a driver
+    try:
+        ctype, drv_class, drv_name = line.split("/", 2)
+        component_name = f"{drv_class}_{drv_name}"
+        # we want to directly access the dict to trigger KeyError, and not catch them here
+        if component_name in dep_data[ctype]:
+            return [component_name]
+        else:
+            raise KeyError(f"Unknown category: {line}")
+    except ValueError:
+        # not three levels of hierarchy, try two
+        pass
+
+    first, second = line.split("/", 1)
+
+    # this could still be a driver, just without the "drivers" prefix
+    for component in dep_data["drivers"].keys():
+        if component == f"{first}_{second}":
+            return [component]
+    # could be driver wildcard, e.g. drivers/net
+    if first == "drivers":
+        drv_match: T.List[str] = [
+            drv_name
+            for drv_name in dep_data["drivers"]
+            if drv_name.startswith(f"{second}_")
+        ]
+        if drv_match:
+            return drv_match
+    # may be category + component
+    if first in dep_data:
+        # go through all components in the category
+        if second in dep_data[first]:
+            return [second]
+        # if it's an app or an example, it may have "dpdk-" in front
+        if first in ["app", "examples"]:
+            maybe_app_name = f"dpdk-{second}"
+            if maybe_app_name in dep_data[first]:
+                return [maybe_app_name]
+    # and nothing of value was found
+    raise ValueError(f"Error: unknown component: {line}")
+
+
+def filter_deps(dep_data: DepData, criteria: T.List[str]) -> None:
+    """Filter dependency data to include only specified components."""
+    # this is a two step process: when we get a list of components, we need to
+    # go through all of them and note any dependencies they have, and expand the
+    # list of components with those dependencies. then we filter.
+
+    # walk the dependency list and include all possible dependencies
+    deps_seen: Deps = set()
+    deps_stack = collections.deque(criteria)
+    while deps_stack:
+        component = deps_stack.popleft()
+        if component in deps_seen:
+            continue
+        deps_seen.add(component)
+        for component_type, component_dict in dep_data.items():
+            try:
+                deps = component_dict[component]
+            except KeyError:
+                # wrong component type
+                continue
+            for _, dep_list in deps.items():
+                deps_stack.extend(dep_list)
+    criteria += list(deps_seen)
+
+    # now, "components" has all the dependencies we need to include, so we can filter
+    for component_type, component_dict in dep_data.items():
+        dep_data[component_type] = {
+            component: deps
+            for component, deps in component_dict.items()
+            if component in criteria
+        }
+
+
+def main():
+    parser = argparse.ArgumentParser(
+        description="Utility to generate dependency tree graphs for DPDK"
+    )
+    parser.add_argument(
+        "--match",
+        type=str,
+        help="Output hierarchy for component or category, e.g. net/ice, lib, app, drivers/net, etc.",
+    )
+    parser.add_argument(
+        "input_file",
+        type=argparse.FileType("r"),
+        help="Path to the deps.dot file from a DPDK build directory",
+    )
+    parser.add_argument(
+        "output_file",
+        type=argparse.FileType("w"),
+        help="Path to the desired output dot file",
+    )
+    args = parser.parse_args()
+
+    deps = read_deps_list([ln.strip() for ln in args.input_file.readlines()])
+    if args.match:
+        try:
+            filter_deps(deps, parse_match(args.match, deps))
+        except (KeyError, ValueError) as e:
+            print(e, file=sys.stderr)
+            return
+    args.output_file.writelines(create_classified_graph(deps))
+
+
+if __name__ == "__main__":
+    main()
-- 
2.43.5

