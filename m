Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7635C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:17:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CFF942E4B;
	Sun, 18 Jan 2026 20:14:42 +0100 (CET)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54]) by mails.dpdk.org (Postfix) with ESMTP id 037F442E4A
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:40 +0100 (CET)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-64b58553449so6440392a12.1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763679;
 x=1769368479; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkoDN3fFC3MyGlB45F9V13Uj20hbcypmHBpBFAPKlGE=;
 b=lXcKeKJMUMR4hZyJdcRpNbnGAReELzTSS8FtEIgsortHiFNhUVljpjMROXQr2H6FQV
 RTinhdLPa8THWIvbQvill/iASndRCmfZSUNZggOc/09XQqhvU0Z7pCFwYnO5ARVeCmTK
 NsOfOPUeSk0QTn4Wh8AuYUxtxO0E0W6x2z0PPm75L8c2Owlcl3hUYccgX2nd0PNbQvQM
 QqTpQVqDmlXTwSG+6gTvAK1AqvtPz/J7T5FV/0QEwXFrKDO363QErD+HcajiuitSTUHo
 aILlhY5OdbrcacNZeP/mKUIUFMEh3/GrFoJONSvQzwkz1cGb4SRJEpHdcafEw/9t+uhm
 PHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763679; x=1769368479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NkoDN3fFC3MyGlB45F9V13Uj20hbcypmHBpBFAPKlGE=;
 b=npcv29ohpl7wPk1BKnDw8v8jO+KI8e4Q4ysqgWboPBYwMtXDw0PptRyFJ4lIrTsyxd
 8/bSdMlRgUtUfPHDENZs41GpLNhI0VrUQ5JM80vZmSb3MkVsVGSvEgQf2pWdbv0K0Fbt
 7VSKirUu88RPm+vhszxrXDYM6PQlVPgmkCpZHjVinQhAFQWHpHvVTpxTllzQzeTGZcBM
 5dH3vuApxci152rCDsaJtD1DNGUU2ko6jB5majalxRYLynF8v+WGQRryFURGkGtj9Vre
 upXEOI1foTkUO2qqBy5li/r4xUiXm/+6fUvEArSij3z3DbqnEK5LyDUOkQY5DH/JNgQe
 NZqw==
X-Gm-Message-State: AOJu0YxJh5MOzCbAsaVsm6pqvATJGyp2Xx84HcMOfLHqNS+4niy5ee8+
 5QoOCj09f58lH+iKjTQLByBS4Occ5uGP9IRnaYWL6ilnA/Pv0U+4+jG73ZIz7x6NNSygqRNCr8E
 uNaaM
X-Gm-Gg: AY/fxX6JkEI5MZOghITTiOVSf27olEGiWQhX6IoXi8Od9S1RsNydOf1+/OJ4UHbWm8Y
 z9hcH4rRbbfMuxneizrR1xSTU+909wevW3/H9YIqA9ubG20LfAQoh7mO90tgpX+TstRpvngq8RR
 UvSy6z2HPoIl+AqUUeDZ6NBq4hK1bAtvr4lnoOZo5tWADFKpx7xeA63mHTNtabOIZtItFJv3FZu
 Ts5SwJSUKOFX0EKd6mlS7GT44QfElA4auo/CVQ8IKYGzktYKhHhZ7alh2anjH4JKmWtyBSftMa8
 l2vhEGlkE4rX+I+jsTtYZHnTpaM4MCzYoS24hi5WMowoIT4752w9tY0VzT2K0w7wyZHuVeKBuBu
 YZcK8jsuvRWYgXGWVPijC4ZCgpOoZgyX3cCp/2cXOtVtZC6tVk02T1MytKqDzgjC0geOUt+DIIE
 8n9H21ayckXke7nPBFT7zp3KpjD75YXPIL9V8AGS+f5MHqOfC8Rw==
X-Received: by 2002:a17:907:7201:b0:b72:70ad:b8f0 with SMTP id
 a640c23a62f3a-b8793244100mr798034366b.36.1768763679405; 
 Sun, 18 Jan 2026 11:14:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 46/54] doc: correct errors in regexdev guide
Date: Sun, 18 Jan 2026 11:10:49 -0800
Message-ID: <20260118191323.241013-47-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct various issues in the RegEx device library documentation:

- fix "Crypto" to "RegEx" in framework description (copy-paste error)
- fix "ReEx" typo to "RegEx"
- remove extra space after "for example"
- fix "in being compiled" to "is being compiled"
- fix "depended" to "dependent"
- fix subject-verb agreement "add / remove" to "adds / removes"
- add missing article "a" before "number of queue pairs"
- fix "feature set" to "feature sets" and complete broken sentence
- fix "it's" to "its"
- fix garbled sentence about data release timing
- fix awkward "API of processed but" phrasing

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/regexdev.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/doc/guides/prog_guide/regexdev.rst b/doc/guides/prog_guide/regexdev.rst
index 3bf3b154b4..2b4f26263e 100644
--- a/doc/guides/prog_guide/regexdev.rst
+++ b/doc/guides/prog_guide/regexdev.rst
@@ -14,7 +14,7 @@ Design Principles
 
 The RegEx library follows the same basic principles as those used in DPDK's
 Ethernet Device framework and the Crypto framework. The RegEx framework provides
-a generic Crypto device framework which supports both physical (hardware)
+a generic RegEx device framework which supports both physical (hardware)
 and virtual (software) RegEx devices as well as a generic RegEx API which allows
 RegEx devices to be managed and configured and supports RegEx operations to be
 provisioned on RegEx poll mode driver.
@@ -29,7 +29,7 @@ Device Creation
 Physical RegEx devices are discovered during the PCI probe/enumeration of the
 EAL function which is executed at DPDK initialization, based on
 their PCI device identifier, each unique PCI BDF (bus/bridge, device,
-function). Specific physical ReEx devices, like other physical devices in DPDK
+function). Specific physical RegEx devices, like other physical devices in DPDK
 can be listed using the EAL command line options.
 
 
@@ -63,7 +63,7 @@ The rte_regexdev_configure API is used to configure a RegEx device.
                               const struct rte_regexdev_config *cfg);
 
 The ``rte_regexdev_config`` structure is used to pass the configuration
-parameters for the RegEx device for example  number of queue pairs, number of
+parameters for the RegEx device for example number of queue pairs, number of
 groups, max number of matches and so on.
 
 .. code-block:: c
@@ -117,13 +117,13 @@ Configuration of Rules Database
 
 Each Regex device should be configured with the rule database.
 There are two modes of setting the rule database, online or offline.
-The online mode means, that the rule database in being compiled by the
+The online mode means that the rule database is being compiled by the
 RegEx PMD while in the offline mode the rule database is compiled by external
 compiler, and is being loaded to the PMD as a buffer.
-The configuration mode is depended on the PMD capabilities.
+The configuration mode is dependent on the PMD capabilities.
 
 Online rule configuration is done using the following API functions:
-``rte_regexdev_rule_db_update`` which add / remove rules from the rules
+``rte_regexdev_rule_db_update`` which adds / removes rules from the rules
 precompiled list.
 
 Offline rule configuration can be done by adding a pointer to the compiled
@@ -134,7 +134,7 @@ rule database in the configuration step, or by using
 Configuration of Queue Pairs
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Each RegEx device can be configured with number of queue pairs.
+Each RegEx device can be configured with a number of queue pairs.
 Each queue pair is configured using ``rte_regexdev_queue_pair_setup``
 
 
@@ -149,9 +149,9 @@ require global locks and hinder performance.
 Device Features and Capabilities
 ---------------------------------
 
-RegEx devices may support different feature set.
-In order to get the supported PMD feature ``rte_regexdev_info_get``
-API which return the info of the device and it's supported features.
+RegEx devices may support different feature sets.
+In order to get the supported PMD features, use the ``rte_regexdev_info_get``
+API which returns the info of the device and its supported features.
 
 
 Enqueue / Dequeue Burst APIs
@@ -165,10 +165,10 @@ The enqueue function returns the number of operations it actually enqueued for
 processing, a return value equal to ``nb_ops`` means that all packets have been
 enqueued.
 
-Data pointed in each op, should not be released until the dequeue of for that
+Data pointed to by each op should not be released until the dequeue for that
 op.
 
-The dequeue API uses the same format as the enqueue API of processed but
+The dequeue API uses the same format as the enqueue API but
 the ``nb_ops`` and ``ops`` parameters are now used to specify the max processed
 operations the user wishes to retrieve and the location in which to store them.
 The API call returns the actual number of processed operations returned, this
-- 
2.51.0

