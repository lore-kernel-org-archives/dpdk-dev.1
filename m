Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E5BCD8C9D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 21:22:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C285433DB;
	Thu, 11 Jun 2026 23:21:34 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 46A30433C9
 for <dev@dpdk.org>; Thu, 11 Jun 2026 23:21:30 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-30807ba471bso912567eec.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781212889;
 x=1781817689; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZeIHVIVu856t5faX0LSbQ2awwfgp01plrv/pdau9Ds=;
 b=ptIDHrs+CZKtY2RJnmyHYSd01exTTKETb5OiiWPf5AEdbHF5xMsgihIwSow1c/k92B
 IyCOOqmmjb4olEqj2yK5JuqBauMHkRQ7V+v2rxXmDxYrxs0kA7r2fQlL59czVcZyA2F3
 ak8boKHbzJ9cX8mTws7chBrcjd6l0IhnpyhEjs2eP5qx4DsTBcVoqgeos1fulRhNPgXZ
 SeWyeYbbf4TWzMcE8wzrQUAmP09OAwJJ+TMjzFXE/4IfBcO5e6x6h3JypMb40fl2Eyb/
 3IOgVq7sElrkwxYGp/KX7aGeM4SAhwc30RaqNN0m+sKSrNEL47XX9vNDv4zeJGguok1p
 HxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212889; x=1781817689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QZeIHVIVu856t5faX0LSbQ2awwfgp01plrv/pdau9Ds=;
 b=QrHmfYStVOMq84xGMN+tSYR/LJ1Oiv3oWMs4mgWwDoiIlWRB7aqu+XMBz5vOMyGFuG
 h3lOY3eHIPI7Y+wLBe6uVsyN30COq9xRvmlB/DKfmpRjJNW5qBHtMVW4KC7gCNgiZdio
 wXl+IJDrxYCLXn3tke6k0imb/MtEc2UUoRxDtLLVdwiTqtYHd6aFsimjSjmtFMpGQJdx
 MarBbLIrKq+pe+S+NhsIbz9nsgXUvp8XlP69xtdlVecOsVHiPO8qn0ozLN3+DEpsWZYd
 tkvn13HrQeQhtFUN2uYRt+dygB+1gA9oRgqi4UnpaUN10tJgdS3I/9Oni56zNihyfJ7k
 9KvA==
X-Gm-Message-State: AOJu0Ywtr1mj921w6jXuH7AfF66WeWOVGe/qROBz/xOXuzvpsq+1b2oX
 iOr9sGaUX9LMwOl0DuBH/o31wei8cqiNcbBUbneloVYWOdA/fwvKMR9073/kDesC/l3n83dEGVA
 TGq3h
X-Gm-Gg: Acq92OGOYZtfi9pGL2LBqiFoG0F6arjv4WzPWViS/qOTfiDwvsh63t2hPIU2Oy6Q8Zj
 Fm1c+Yk1MTikiVpB8ieqirbhqNLk0MgK7nI+Z/uIWHO3w5VzwDIZ7r0e1jYSilLSrdW1v3FwAde
 pwJMUOQc9vzzkJ9oBnx/yAjuj40+DsOlE9+nM9QAE9P1+JLc7wtAF5DYFZf483HGGvSwgBPe3zw
 JQpyVJIFMln/Pd7jCprvg2UwU6QB2JdlnSfqNUfE5/Mtp+pzY9jt4DCyfDO0MGObbI+0AC8KHbC
 CfEthj2ZL+SRD40+qkUX24YgC6Gjva5uJLcHzcsW7bmcQenha+uzrZshWKdl/nj0gnMzBc31Tbf
 1D9zpscmU11ISH9N/DCP+ENGwCR0AAG5430Qc57XQL2lBsd0+iV19/9cONno+2TWpi7KqaOrJve
 3DYTlQaNXT8aMWvLqDf4DfvWydhw59HdD50O7eGAAQqUvCeEg/mHtCGlZ5LEe3bw==
X-Received: by 2002:a05:7300:fd15:b0:304:8366:7456 with SMTP id
 5a478bee46e88-3081ff41333mr57086eec.3.1781212889053; 
 Thu, 11 Jun 2026 14:21:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95450sm546238eec.28.2026.06.11.14.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:21:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Ori Kam <orika@nvidia.com>
Subject: [PATCH 07/15] doc: improve clarity in eventdev, FIPS,
 and flow filtering
Date: Thu, 11 Jun 2026 14:18:46 -0700
Message-ID: <20260611212119.1026721-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611212119.1026721-1-stephen@networkplumber.org>
References: <20250216230903.124496-1-nandinipersad361@gmail.com>
 <20260611212119.1026721-1-stephen@networkplumber.org>
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

Enhanced multiple sample application guides:

eventdev_pipeline.rst:
- Improved command-line option formatting and descriptions
- Standardized terminology and fixed grammatical issues
- Clarified pipeline stage descriptions

fips_validation.rst:
- Restructured algorithm support sections for clarity
- Fixed formatting inconsistencies
- Improved readability of validation process descriptions

flow_filtering.rst:
- Enhanced code explanations and flow descriptions
- Fixed formatting and indentation issues
- Clarified API usage examples

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .../sample_app_ug/eventdev_pipeline.rst       | 51 ++++++++-------
 doc/guides/sample_app_ug/fips_validation.rst  | 63 +++++++++----------
 doc/guides/sample_app_ug/flow_filtering.rst   | 51 +++++++--------
 3 files changed, 82 insertions(+), 83 deletions(-)

diff --git a/doc/guides/sample_app_ug/eventdev_pipeline.rst b/doc/guides/sample_app_ug/eventdev_pipeline.rst
index 19ff53803e..343d3f46ec 100644
--- a/doc/guides/sample_app_ug/eventdev_pipeline.rst
+++ b/doc/guides/sample_app_ug/eventdev_pipeline.rst
@@ -4,41 +4,40 @@
 Eventdev Pipeline Sample Application
 ====================================
 
-The eventdev pipeline sample application is a sample app that demonstrates
+The eventdev pipeline sample application is an application that demonstrates
 the usage of the eventdev API using the software PMD. It shows how an
 application can configure a pipeline and assign a set of worker cores to
 perform the processing required.
 
-The application has a range of command line arguments allowing it to be
-configured for various numbers worker cores, stages,queue depths and cycles per
-stage of work. This is useful for performance testing as well as quickly testing
+The application has a range of command line arguments that allow it to be
+configured for various numbers of worker cores, stages, queue depths, and cycles
+per stage of work. This is useful for performance testing as well as quickly testing
 a particular pipeline configuration.
 
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
-
-The application is located in the ``examples`` sub-directory.
+To compile the sample application, see :doc:`compiling`.
 
+The application is located in the ``examples`` directory.
 
 
 Running the Application
 -----------------------
 
-The application has a lot of command line options. This allows specification of
-the eventdev PMD to use, and a number of attributes of the processing pipeline
+The application has a lot of command line options. This allows the specification of
+the eventdev PMD to use and for a number of attributes of the processing pipeline
 options.
 
 An example eventdev pipeline running with the software eventdev PMD using
 these settings is shown below:
 
- * ``-l 0,2,8-15``: lcore to use
+ * ``-l 0,2,8-15``: lcores to use
  * ``-r1``: core mask 0x1 for RX
  * ``-t1``: core mask 0x1 for TX
  * ``-e4``: core mask 0x4 for the software scheduler
- * ``-w FF00``: core mask for worker cores, 8 cores from 8th to 16th
+ * ``-w FF00``: core mask for worker cores, 8 cores from 8th to 15th
  * ``-s4``: 4 atomic stages
  * ``-n0``: process infinite packets (run forever)
  * ``-c32``: worker dequeue depth of 32
@@ -50,8 +49,8 @@ these settings is shown below:
     ./<build_dir>/examples/dpdk-eventdev_pipeline -l 0,2,8-15 --vdev event_sw0 \
     -- -r1 -t1 -e4 -w FF00 -s4 -n0 -c32 -W1000 -D
 
-The application has some sanity checking built-in, so if there is a function
-(e.g.; the RX core) which doesn't have a cpu core mask assigned, the application
+The application has sanity checking built-in, so if there is a function
+(e.g., the RX core) which does not have a CPU core mask assigned, the application
 will print an error message:
 
 .. code-block:: console
@@ -61,26 +60,26 @@ will print an error message:
           rx: 0
           tx: 1
 
-Configuration of the eventdev is covered in detail in the programmers guide,
-see the Event Device Library section.
+Configuration of the eventdev is covered in detail in the programmer's guide.
+See the Event Device Library section.
 
 
 Observing the Application
--------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
-At runtime the eventdev pipeline application prints out a summary of the
-configuration, and some runtime statistics like packets per second. On exit the
-worker statistics are printed, along with a full dump of the PMD statistics if
+At runtime, the eventdev pipeline application prints out a summary of the
+configuration, and some runtime statistics like packets per second. On exit, the
+worker core statistics are printed, along with a full dump of the PMD statistics if
 required. The following sections show sample output for each of the output
 types.
 
 Configuration
-~~~~~~~~~~~~~
+^^^^^^^^^^^^^
 
-This provides an overview of the pipeline,
-scheduling type at each stage, and parameters to options such as how many
-flows to use and what eventdev PMD is in use. See the following sample output
-for details:
+The configuration output provides an overview of the pipeline, the scheduling
+type at each stage,
+and parameters such as the number of flows and the eventdev PMD in use.
+See the following sample output for details:
 
 .. code-block:: console
 
@@ -101,7 +100,7 @@ for details:
         Stage 3, Type Atomic    Priority = 128
 
 Runtime
-~~~~~~~
+^^^^^^^
 
 At runtime, the statistics of the consumer are printed, stating the number of
 packets received, runtime in milliseconds, average mpps, and current mpps.
@@ -111,7 +110,7 @@ packets received, runtime in milliseconds, average mpps, and current mpps.
   # consumer RX= xxxxxxx, time yyyy ms, avg z.zzz mpps [current w.www mpps]
 
 Shutdown
-~~~~~~~~
+^^^^^^^^
 
 At shutdown, the application prints the number of packets received and
 transmitted, and an overview of the distribution of work across worker cores.
diff --git a/doc/guides/sample_app_ug/fips_validation.rst b/doc/guides/sample_app_ug/fips_validation.rst
index 613c5afd19..732f47212a 100644
--- a/doc/guides/sample_app_ug/fips_validation.rst
+++ b/doc/guides/sample_app_ug/fips_validation.rst
@@ -7,13 +7,13 @@ Federal Information Processing Standards (FIPS) CryptoDev Validation
 Overview
 --------
 
+This application parses and performs symmetric cryptography computations
+using test vectors from the NIST Cryptographic Algorithm Validation Program
+(CAVP) and Automated Crypto Validation Protocol (ACVP).
+
 Federal Information Processing Standards (FIPS) are publicly announced standards
 developed by the United States federal government for use in computer systems by
-non-military government agencies and government contractors.
-
-This application is used to parse and perform symmetric cryptography
-computation to the NIST Cryptographic Algorithm Validation Program (CAVP) and
-Automated Crypto Validation Protocol (ACVP) test vectors.
+non-military agencies and government contractors.
 
 For an algorithm implementation to be listed on a cryptographic module
 validation certificate as an Approved security function, the algorithm
@@ -21,6 +21,7 @@ implementation must meet all the requirements of FIPS 140-2 (in case of CAVP)
 and FIPS 140-3 (in case of ACVP) and must successfully complete the
 cryptographic algorithm validation process.
 
+
 Limitations
 -----------
 
@@ -28,17 +29,17 @@ CAVP
 ----
 
 * The version of request file supported is ``CAVS 21.0``.
-* If the header comment in a ``.req`` file does not contain a Algo tag
-  i.e ``AES,TDES,GCM`` you need to manually add it into the header comment for
-  example::
+* If the header comment in a ``.req`` file does not contain an algorithm tag
+  (i.e., ``AES``, ``TDES``, ``GCM``), you must manually add it to the header
+  comment, for example::
 
       # VARIABLE KEY - KAT for CBC / # TDES VARIABLE KEY - KAT for CBC
 
-* The application does not supply the test vectors. The user is expected to
-  obtain the test vector files from `CAVP
+* The application does not supply the test vectors. Users must obtain the
+  test vector files from the `CAVP
   <https://csrc.nist.gov/projects/cryptographic-algorithm-validation-
-  program/block-ciphers>`_ website. To obtain the ``.req`` files you need to
-  email a person from the NIST website and pay for the ``.req`` files.
+  program/block-ciphers>`_ website. To obtain the ``.req`` files, you need to
+  contact a representative from the NIST website and pay for the ``.req`` files.
   The ``.rsp`` files from the site can be used to validate and compare with
   the ``.rsp`` files created by the FIPS application.
 
@@ -54,7 +55,7 @@ CAVP
 ACVP
 ----
 
-* The application does not supply the test vectors. The user is expected to
+* The application does not supply the test vectors. Users must
   obtain the test vector files from `ACVP  <https://pages.nist.gov/ACVP>`_
   website.
 * Supported test vectors
@@ -78,19 +79,17 @@ ACVP
 Application Information
 -----------------------
 
-If a ``.req`` is used as the input file after the application is finished
-running it will generate a response file or ``.rsp``. Differences between the
-two files are, the ``.req`` file has missing information for instance if doing
-encryption you will not have the cipher text and that will be generated in the
-response file. Also if doing decryption it will not have the plain text until it
-finished the work and in the response file it will be added onto the end of each
-operation.
-
-The application can be run with a ``.rsp`` file and what the outcome of that
-will be is it will add a extra line in the generated ``.rsp`` which should be
-the same as the ``.rsp`` used to run the application, this is useful for
-validating if the application has done the operation correctly.
+If a ``.req`` file is used as input, the application generates a response
+file (``.rsp``) after completion. The ``.req`` file has missing fields that
+the application fills in. For example, when
+performing encryption the cipher text is absent; when performing decryption
+the plain text is absent. These are computed and added to the ``.rsp`` file
+at the end of each operation.
 
+The application can also run with a ``.rsp`` file as input. In this case,
+it generates a new ``.rsp`` with an additional verification line. The output
+should match the input ``.rsp``, which is useful for validating that the
+application performed the operations correctly.
 
 Compiling the Application
 -------------------------
@@ -125,23 +124,23 @@ The application requires a number of command line options:
          --mbuf-dataroom DATAROOM_SIZE
 
 where,
-  * req-file: The path of the request file or folder, separated by
+  * req-file: The path of the request file or folder, indicated by
     ``path-is-folder`` option.
 
-  * rsp-file: The path that the response file or folder is stored. separated by
+  * rsp-file: The path where the response file or folder is stored, indicated by
     ``path-is-folder`` option.
 
   * cryptodev: The name of the target DPDK Crypto device to be validated.
 
   * cryptodev-id: The id of the target DPDK Crypto device to be validated.
 
-  * path-is-folder: If presented the application expects req-file and rsp-file
-    are folder paths.
+  * path-is-folder: If present, the application treats req-file and rsp-file
+    as folder paths.
 
   * mbuf-dataroom: By default the application creates mbuf pool with maximum
-    possible data room (65535 bytes). If the user wants to test scatter-gather
-    list feature of the PMD he or she may set this value to reduce the dataroom
-    size so that the input data may be divided into multiple chained mbufs.
+    possible data room (65535 bytes). To test the scatter-gather
+    list feature of a PMD, this value may be set to reduce the dataroom
+    size so that the input data is divided into multiple chained mbufs.
 
 
 To run the application in linux environment to test one AES FIPS test data
diff --git a/doc/guides/sample_app_ug/flow_filtering.rst b/doc/guides/sample_app_ug/flow_filtering.rst
index 179e978942..db5947d9e4 100644
--- a/doc/guides/sample_app_ug/flow_filtering.rst
+++ b/doc/guides/sample_app_ug/flow_filtering.rst
@@ -7,11 +7,11 @@ Flow Filtering Sample Application
 Overview
 --------
 
-The flow filtering sample application provides a simple example of creating flow rules.
+The flow filtering sample application is a simple example of creating flow rules.
 
 It serves as a demonstration of the fundamental components of flow rules.
 
-It demonstrates how to create rules and configure them, using both template and non template API.
+It demonstrates how to create and configure rules using both template and non-template APIs.
 
 
 Compiling the Application
@@ -25,7 +25,7 @@ The application is located in the ``flow_filtering`` sub-directory.
 Running the Application
 -----------------------
 
-To run the example in a ``linux`` environment:
+To run the example in a Linux environment:
 
 .. code-block:: console
 
@@ -34,7 +34,7 @@ To run the example in a ``linux`` environment:
 where,
 
 ``--[non-]template``
-  Specify whether to use the template API (default is template API).
+  Specifies whether to use the template API (default is template API).
 
 For more details on template API please refer to :ref:`flow_template_api`.
 
@@ -50,7 +50,7 @@ The example is built from 2 main files:
 - ``main.c``: Contains the application logic, including initializations and the main loop.
 - ``flow_skeleton.c``: Implements the creation of flow rules.
 
-Additionally, the ``snippets`` directory includes code snippets showcasing various features
+Additionally, the ``snippets`` directory contains code snippets showcasing various features
 that can override the basic ``flow_skeleton.c`` implementation.
 
 
@@ -87,7 +87,7 @@ those configuration are defined in the snippet file.
    :end-before: >8 End of snippet-specific configuration.
    :dedent: 1
 
-Initialize the ports using the user-defined ``init_port()`` function,
+Initialize the ports using the ``init_port()`` function,
 configuring Ethernet ports with default settings, including both Rx and Tx queues for a single port:
 
 .. literalinclude:: ../../../examples/flow_filtering/main.c
@@ -96,7 +96,7 @@ configuring Ethernet ports with default settings, including both Rx and Tx queue
    :end-before: >8 End of Initializing the ports using user defined init_port().
    :dedent: 1
 
-For template API, the flow API requires preallocating resources.
+For the template API, the flow API requires preallocating resources.
 The function ``rte_flow_configure()`` should be called after configuring the Ethernet device
 and before creating any flow rules to set up flow queues for asynchronous operations.
 
@@ -109,14 +109,14 @@ and before creating any flow rules to set up flow queues for asynchronous operat
 Creating the Flow Rule
 ~~~~~~~~~~~~~~~~~~~~~~
 
-This section is the core of the flow filtering functionality involves creating flow rules.
-The flow rules are created using two primary approaches: template API and non-template API.
-Both template and non-template API configure flow rules using attributes (like ingress or egress),
-pattern items (for matching packet data), and actions (for operations on matched packets).
-However, template API extend this by introducing pattern templates and actions templates,
+This section covers the core of the flow filtering functionality: creating flow rules.
+Flow rules are created using two primary approaches: template API and non-template API.
+Both APIs configure flow rules using the same components: attributes (such as ingress or egress),
+pattern items (for matching packet data), and actions (to perform operations on matched packets).
+However, the template API extends this by introducing pattern templates and action templates,
 which define reusable matching criteria and action lists, respectively.
-These templates are then combined in a template table to optimize resource allocation and management.
-In contrast, non-template API handle each rule individually without such shared templates.
+The pattern and action templates are combined in a template table to optimize resource allocation.
+In contrast, the non-template API handles each rule individually without such shared templates.
 
 This is handled by the ``generate_flow_skeleton()`` function in ``flow_skeleton.c``.
 
@@ -127,8 +127,8 @@ This is handled by the ``generate_flow_skeleton()`` function in ``flow_skeleton.
    :dedent: 1
 
 This part of the code defines necessary data structures,
-as well as configures action and pattern structures for the rule.
-Common for both template and non-template API.
+and configures action and pattern structures for the rule.
+This is common to both template and non-template APIs.
 
 .. literalinclude:: ../../../examples/flow_filtering/flow_skeleton.c
    :language: c
@@ -136,7 +136,7 @@ Common for both template and non-template API.
    :end-before: >8 End of setting the common action and pattern structures.
    :dedent: 1
 
-For template API, this part of the code creates the necessary template tables and finally create the rule.
+For the template API, the code creates pattern and action templates, combines them in a template table, and creates the rule.
 
 .. literalinclude:: ../../../examples/flow_filtering/flow_skeleton.c
    :language: c
@@ -144,7 +144,7 @@ For template API, this part of the code creates the necessary template tables an
    :end-before: >8 End of creating a flow rule using template API.
    :dedent: 1
 
-For non-template API, validate the rule and create it.
+For the non-template API, the code validates and creates the rule directly.
 
 .. literalinclude:: ../../../examples/flow_filtering/flow_skeleton.c
    :language: c
@@ -156,7 +156,7 @@ Main Loop Execution
 ~~~~~~~~~~~~~~~~~~~
 
 Launch the ``main_loop()`` function from ``main.c``,
-which reading the packets from all queues and printing for each packet the destination queue:
+which reads packets from all queues and prints the destination queue for each packet:
 
 .. literalinclude:: ../../../examples/flow_filtering/main.c
    :language: c
@@ -186,18 +186,19 @@ Using Snippets
 
 Developers can customize flow rules by modifying ``flow_skeleton.c``
 and utilizing functions from ``snippets`` directory.
-For example, within ``snippet_match_ipv4_flow.c``, developers can find the functions:
+For example, ``snippet_match_ipv4_flow.c`` provides:
 
 - ``snippet_ipv4_flow_create_actions()`` for defining actions,
 - ``snippet_ipv4_flow_create_patterns()`` for setting packet matching patterns,
 - ``snippet_ipv4_flow_create_table()`` for creating the patterns and actions template table.
 
-To use a different snippet, simply update the include statement in ``flow_skeleton.c``
-to point to the desired snippet file, this will change the default created flow.
+To use a different snippet, update the include statement in ``flow_skeleton.c``
+to point to the desired snippet file. This will change the default flow rule created.
 
-Some snippets may require different configuration,
-those configuration are defined in the snippet file:
+Some snippets require additional port or flow configuration.
+These are defined in the snippet header file, for example:
 
 - ``snippet_init_ipv4`` for configuration of the port and flow attributes.
 
-In order to use them the developer should include the snippet header file in main.c
+To apply these configurations, include the snippet header file in ``main.c``
+so that the snippet-specific initialization is called during port setup.
-- 
2.53.0

