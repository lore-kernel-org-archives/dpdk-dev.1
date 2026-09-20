Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9126AC982D8
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:16:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECE49427AC;
	Sun, 20 Sep 2026 20:14:37 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id 085E540E43
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:28 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc4cdc0d663so1398166a12.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928067;
 x=1790532867; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CrpwQ8i4fl71NDcI6nMJQybK8wjxaXtksuSUEGn1T4U=;
 b=zxfcf0HdIri07eIyEQkWG7p95TYlK5HQMNnAaqm6Y7gRI8YB5lEhjo8GCnNgnf2D4w
 G8pv553aLMon/oCVQDyPTmqQj2GU6zVDEJ4bBJD+2ILDK/nJkf1LN8Pr8l412CWyDPT0
 QqBjnOzQzQJNyLdnOBlakvDQfeym37iIKnQU5SYyytHa0XgeTY4dUy2KXU18aAvo04Au
 OpsZcvQUnBTVI8cZfmCgu1LQ9/ANz9zQrCqqsQPeX9JJGf4R19Nvp9cpGWAGUd1S/SVS
 95UiJcu/RY0ToRtfgNWM851cSF8UOxeE4f+/Y9stE0wepYKGiGkdvdn0meVgCqixeSyC
 w+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928067; x=1790532867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CrpwQ8i4fl71NDcI6nMJQybK8wjxaXtksuSUEGn1T4U=;
 b=PlxfhybtSIQJm6rBPFWdg9oxhHbICu37tuq954mWAmaQQiMoAzSKIAmScMvjvew4K+
 5LEIatuLQOHPsLxmsYmZidrb2g9R5TwW4BICZ2XNGuoU8mHfjXTRm8SBoEpc8GMACRtB
 LRp8lQ+as4HsRqTHnvsG5NsO42hYnODTctn8PfHoN0pGJzEImKQvstQzuRkoPMQPjq47
 9lvpg5G0QXa41N0COA89qvY+5oyyDITS88Y+7atW7OBaNSpYIked/3WHVdjGwJlWeCaJ
 rzM71HiTe9ltqqVZFNEwnKPnzjIrWHjHVCmytBP4C76BTk6YY5cgnQ2ePe/YDq3j38NY
 VWew==
X-Gm-Message-State: AFuF++nMC0aRNdTsyLoUN7lgxZUmtn/mLeljUy2RWBvZ8F4kJIw7bWfI
 MlaCYJ5bA+op352jU4bVvE6NPart8rpIAm1z2eV53YrPZzorasqFhO8g1N6n+K/BYBiLZ4TWHJP
 xL0I3
X-Gm-Gg: AYBFou25krrjf9K5h5+kjX46DxHO/NnyEKxnk6q8E81ViKjnoCVOauWh/+vvuDWO11A
 VsDH/bEcFwnbSfLGEy9PyGQLp7ivut+/KZIvGNcHMLAkFl72uXBv01Jtc6/L0zoApIQtSLwPHEm
 OYo5OLy308pvp0rw3QzWupoohthLX1XYJhblPD5zMqLtzfZQdONHQS9eKXexDvr0zsEkn686bKm
 jR+0SaBI4kn8GzaGtkBlZ50VW6gXu4Rv1L5PzOq4tqbhyITaBhTjNDewzv5E+f84b/ED+xRnRRG
 Zhb0ttOwFOuKRVsES4z9y9qKBhZkdTEgYIJVPYTm+AAGQaXPQ0w4qc6uV8jCl+xCEju7UoLgI0s
 98COUct0XLPDoZvycg4WohVoFVmNY5e7f3HsDtSvm8peGNMktiKcL0bfC2wYw994Ey5C2gAYTsi
 jH3ft5TBeWuV2rGYcHb2f23WGQJ/lDj1oHeDKnpZtunY0Ht99847Hwv46W79jrt3P4Z1FCDf0jn
 pAB1PpVndyPNRUcyH086Hj7nU01+h0tM8LMtQ==
X-Received: by 2002:a17:90b:554b:b0:39e:6c6a:2097 with SMTP id
 98e67ed59e1d1-39e6c6a2359mr6670635a91.56.1789928067156; 
 Sun, 20 Sep 2026 11:14:27 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v2 32/33] checkpatches: no longer warn about rte_smp_XX
Date: Sun, 20 Sep 2026 11:10:24 -0700
Message-ID: <20260920181347.747210-33-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

These macros/functions are now removed.
Any new use will be detected as compile errors.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/checkpatches.sh | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index 18bd825372..3649645488 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -129,14 +129,6 @@ check_forbidden_additions() { # <patch>
 		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
 		"$1" || res=1
 
-	# refrain from new additions of rte_smp_[r/w]mb()
-	awk -v FOLDERS="lib drivers app examples" \
-		-v EXPRESSIONS="rte_smp_(r|w)?mb\\\(" \
-		-v RET_ON_FAIL=1 \
-		-v MESSAGE='Using rte_smp_[r/w]mb' \
-		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
-		"$1" || res=1
-
 	# refrain from using compiler __sync_xxx builtins
 	awk -v FOLDERS="lib drivers app examples" \
 		-v EXPRESSIONS="__sync_.*\\\(" \
-- 
2.53.0

