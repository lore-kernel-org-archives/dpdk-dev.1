Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB3BC3ABC9
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 20:26:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CFD040615;
	Fri, 16 May 2025 22:26:09 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 930C340395
 for <dev@dpdk.org>; Fri, 16 May 2025 22:26:08 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-6f8b0f7c42dso2540406d6.2
 for <dev@dpdk.org>; Fri, 16 May 2025 13:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747427168; x=1748031968; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2Ew2aMXAKRlUWHEAhOesl6egvoGx213O+x2kWU8O9NA=;
 b=ezzgUQk3fmverh8kLiStqoozsVcY7N5hHfCSEfClUgTXErpObrloxx3wRc8KQNKK00
 oPMtPjnLzRAS7uF1F/ffmMB4GyDmEOr+J51DaNB5s5WMUSh4s4zt3eXhJnXtDHM/dvY+
 2bKMbC/TT41PDC/nIvtS4U/8rizgqcmA/hXMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747427168; x=1748031968;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Ew2aMXAKRlUWHEAhOesl6egvoGx213O+x2kWU8O9NA=;
 b=nk0/1Mod9ac7rbU8lJyZhVAhxHtiIqQeGgMZSzEff9zTtBxo6e95M+XgD9anRgeKoE
 Si75uMaaEEYX1R0Epdpo5HihY1GGuF8CH7/ZRRDuWMW9r6vZtT5p0fO8P6a1+G7+zjx0
 cU3bSPwA3KKSVCainIQyPVbriR9V7aBJ/Y7HgTB6R8h+TKTN3DZefCL9oadgpYzLdBTN
 8s7XahIDUxoYU1HShMQ3T7G77oNEcK8rF0yWkYcOsdYi8e9ImxZEheOh8YhZ8gA+ma6e
 mYhjG7RztjFNF58kpIw9AJC1IhyYw9CZBUHuMLZadynLseqoMFnNEOWyg0wGEIELeF2j
 jxhw==
X-Gm-Message-State: AOJu0Yx14/2ifbFHjLIJhAtPL/mL5grrZ76XEzCdd7AtkqaCR7jdl6wR
 Uu3Qi8l1px50hm7hq6Kb8dY9cVecbsm/p14byurbRj4iTbi4Fe9z349RolluEmnwAGA=
X-Gm-Gg: ASbGnctWBJH+M61NggimhVxuOLFJlloz45RRO2nTDwqOuZB3BLzJmWDuVdNKJQlV1z4
 2o1rVzEWwpeJTFQFy/ZElEvd/MoLGT/kwAJY4uHMZDkzt6Mx3M4AOszOz5YxJoa4PU4RKd7hKNG
 IgGVszpACKMMej98+OOPOjFEdHr2rCyQ6A4D/Amyua9c3p3Qenm0Z9KwYlnOQdIxxejYEpvbQ7U
 qP1rXewUZCWfqfvvbuup9W0bU1aTZRw2H7tio5nxJieWuDprx6Yr0fsgUTyruURHbmxhZbIxtZb
 IGCLifeNdUyq8sKKqKCEPrXlJZflhY9TNafPDV8SzspyB+0Kb/jn1xCZnX4U7ps=
X-Google-Smtp-Source: AGHT+IEj93000J9N8spXHDwCsr+DiNn0OMxKj6POWSz+6pYfP2NVJXYigAFCo3YNG1WaF8felVzNGA==
X-Received: by 2002:ac8:574b:0:b0:476:addb:c452 with SMTP id
 d75a77b69052e-494ae353313mr22461981cf.6.1747427167739; 
 Fri, 16 May 2025 13:26:07 -0700 (PDT)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-494ae4fd7f0sm15287621cf.57.2025.05.16.13.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 13:26:07 -0700 (PDT)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: luca.vizzarro@arm.com, thomas@monjalon.net, probb@iol.unh.edu,
 dmarx@iol.unh.edu, paul.szczepanek@arm.com, Honnappa.Nagarahalli@arm.com,
 thomas.wilks@arm.com, yoan.picchi@foss.arm.com, stephen@networkplumber.org
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [PATCH] doc: elaborate on per test suite configuration dts docs
Date: Fri, 16 May 2025 16:26:01 -0400
Message-ID: <20250516202600.632070-2-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
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

Introduce some additional documentation explaing the per test suite
configuration component of DTS as the current dts documentation does
not provide a quick access reference guide or explanation.

Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
---
 doc/guides/tools/dts.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index fcc6d22036..951b5462e2 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -405,6 +405,13 @@ There are four types of methods that comprise a test suite:
    If there's any functionality or logic missing from the framework,
    it should be implemented so that the test suites can use one of these two ways.
 
+   Test suites may also be configured individually using a provided configuration file,
+   provided at the command line, for custom configuration. The configuration file is a simple
+   mapping of test suite names to their corresponding configurations.
+
+   Any test suite can be designed to require custom configuration attributes or optional ones.
+   Any optional attributes should supply a default value for the test suite to use.
+
 #. **Test case verification**
 
    Test case verification should be done with the ``verify`` method, which records the result.
@@ -507,3 +514,18 @@ And they both have two network ports which are physically connected to each othe
 .. literalinclude:: ../../../dts/nodes.example.yaml
    :language: yaml
    :start-at: # Define
+
+Additionally, an example configuration file is provided to demonstrate custom test suite configuration:
+
+.. note::
+   You do not neeed to supply configurations for all test suites, and not all test suites will support
+   or need additional configuration.
+
+.. _tests_config_example:
+
+``dts/tests_config.example.yaml``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. literalinclude:: ../../../dts/tests_config.example.yaml
+   :language: yaml
+   :start-at: # Define
\ No newline at end of file
-- 
2.47.1

