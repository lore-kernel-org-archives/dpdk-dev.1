Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC88C87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 11:46:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B71B4065A;
	Fri,  1 Aug 2025 13:45:59 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id F25B840263
 for <dev@dpdk.org>; Fri,  1 Aug 2025 13:45:57 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 221491516;
 Fri,  1 Aug 2025 04:45:49 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.1.123])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A045D3F66E;
 Fri,  1 Aug 2025 04:45:56 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
	Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH] dts: remove optional docs dependencies
Date: Fri,  1 Aug 2025 12:45:47 +0100
Message-ID: <20250801114547.1128950-1-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
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

The CI currently does not support the optional DTS docs dependencies. As
a consequence, all of the public docs are always built and deployed without
them.

To simplify the maintenance process, remove the optional docs dependencies
and abandon support.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 doc/guides/conf.py       | 7 -------
 doc/guides/tools/dts.rst | 5 -----
 dts/pyproject.toml       | 9 ---------
 3 files changed, 21 deletions(-)

diff --git a/doc/guides/conf.py b/doc/guides/conf.py
index 4b1059c202..2c1aa81bbf 100644
--- a/doc/guides/conf.py
+++ b/doc/guides/conf.py
@@ -65,13 +65,6 @@
         graphviz_output_format = "svg"
         tags.add("graphviz")
 
-    # Pydantic models require autodoc_pydantic for the right formatting. Add if installed.
-    try:
-        import sphinxcontrib.autodoc_pydantic
-        extensions.append("sphinxcontrib.autodoc_pydantic")
-    except ImportError:
-        pass
-
     # Napoleon enables the Google format of Python doscstrings.
     napoleon_numpy_docstring = False
     napoleon_attr_annotations = True
diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 78761dc49e..3837b398cf 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -491,11 +491,6 @@ Building DTS API docs
 The documentation is built using the standard DPDK build system.
 See :doc:`../linux_gsg/build_dpdk` for more details on compiling DPDK with meson.
 
-.. code-block:: console
-
-   poetry install --only docs
-   poetry install --with docs  # an alternative that will also install DTS dependencies
-
 After executing the meson command, build the documentation with:
 
 .. code-block:: console
diff --git a/dts/pyproject.toml b/dts/pyproject.toml
index 8df0a894dc..8b061c3cee 100644
--- a/dts/pyproject.toml
+++ b/dts/pyproject.toml
@@ -35,15 +35,6 @@ types-paramiko = "^3.5.0.20240928"
 types-invoke = "^2.0.0.10"
 types-pyyaml = "^6.0.12.20240917"
 
-[tool.poetry.group.docs]
-optional = true
-
-[tool.poetry.group.docs.dependencies]
-sphinx = "<=7"
-sphinx-rtd-theme = ">=1.2.2"
-pyelftools = "^0.31"
-autodoc-pydantic = "^2.2.0"
-
 [build-system]
 requires = ["poetry-core>=1.0.0"]
 build-backend = "poetry.core.masonry.api"
-- 
2.43.0

