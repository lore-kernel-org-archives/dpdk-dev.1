Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14106C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 14:26:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B2AE40287;
	Thu, 26 Jun 2025 16:26:55 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 84BA540156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 16:26:54 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-236470b2dceso12170595ad.0
 for <dev@dpdk.org>; Thu, 26 Jun 2025 07:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750948013;
 x=1751552813; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzwCvzP41YR4J9Y9sXfTFgwOjYbh8ZBrIJG5gNYyieQ=;
 b=B6wAIgcCT32kpVoG3FHWV8qgTcEfTIWAAO6pz3mjNGOsXWYsoPqGGnU+yeykl8hs3v
 AEYYYQzptpA/HeqBjb6ga+GMn1peHbPnn46JhhrFEIqMKQm5sTe9ulxTW3pD6qosvhrk
 CrpfLgh8qJmMtCtvdhf+kd1NTTGJPQYfy3QnVOIaG3I1ku1QuVuOvhjccoC4cN6U2crJ
 5oAJsr+QZwJ9of8d0ZIJFparebD7w/tgiyNP3qyz1lN8CmLbN9+BQ2CKHVJFaHz3U7lz
 1pZVROMQ8JIpF9pBBlKyv1682Ex3xLsiFLpBphRiZj8FQhwcd2ETw21hKMNdwE7u6bU5
 5v8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750948013; x=1751552813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LzwCvzP41YR4J9Y9sXfTFgwOjYbh8ZBrIJG5gNYyieQ=;
 b=GcRUzEgtA/Q78SCssqiXf9vqLWQ7BqBbsYWU55yMQGj8S6UJ6ByG3kn+JIgAB3d3xI
 RwpLaLHgBI5daKSrRY4tkG9zSpiuQMYtMiXa91Hn9BnqstmRtU/fGS90s4V/jgAW61cm
 vuhVb/nRX/So0Xjx/TqosijA5q8T1O0G1ujQ0DKNtXIEmAsqV7S1q+BleXcu2D+59qdn
 UwQMOXMsjeqGratLaseyxIHJvyL3KA9Q6QsbHka2AihnlwgrobsEZ/pfdl6FX5pgbeWR
 bT92OtH4Za4WSIk5Vc8crNk8dqo4UjD7yiCEpohqaBfGAxriWSa9fUSrONKFG3+P3rIH
 jkYg==
X-Gm-Message-State: AOJu0YwhTEjn602zH8imEZELb9bxMgoLxubu4o7IEVzn0X/xNGtUVWIe
 z9947paHEo4XQZkPUeRpLj0CIL8C1P+s9Z3vglH0Nd9+aEQTDvIm/DxBiceDJaK/uzU=
X-Gm-Gg: ASbGncuZpPILBahFHzuPBapdgVv1Ddql2JYZyRw/7K5aQyIhxuDDT7j+ubLyUCaaOxd
 mJHYhIe50tgTYnJ/uU5IJsbq41ZNW/LRfIaDCrfiJM38+MhCNRqX2qp1F4niBwwSEy/nV5S9axX
 LhEPxcmOPY5pLpj8WcLTyt6pDWFndGTpGEN3oURB5gVPeKBUQDyMf3LXqb1TZcHopHc+ogf4u6Q
 2AE08is1NMvB+3JzRLSra2vpPlrXo4zbEWTigzAbl4U60goAvKIjODdQi6b3javONeJwlKz7FZC
 XEox+CSNxKnSgdwUvvl1kOXgg3RWGf16Jwmpg/bWBaDPM6ZQ21IzVoJLxud6ZT8DTrmHXAaPLBG
 cIFehXmvn1ygbAKszEDtNYtkRC+3jRdyH+4Fi6q4=
X-Google-Smtp-Source: AGHT+IGZ0mbv2WwWez73QvAwI08HPECdEWwfh3YNwov7SaKiI0IE+4sj6BgXKvscmvnM9ovG07ZV8Q==
X-Received: by 2002:a17:903:2a8e:b0:234:dd3f:80fd with SMTP id
 d9443c01a7336-23823f88a80mr127069325ad.2.1750948013351; 
 Thu, 26 Jun 2025 07:26:53 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d860a387sm159093205ad.115.2025.06.26.07.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 07:26:53 -0700 (PDT)
Date: Thu, 26 Jun 2025 07:26:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH] ethdev: sync ethtool link modes with Linux 6.15
Message-ID: <20250626072651.79d51099@hermes.local>
In-Reply-To: <20250625134202.3193570-1-thomas@monjalon.net>
References: <20250625134202.3193570-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 25 Jun 2025 15:42:02 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> diff --git a/lib/ethdev/ethdev_linux_ethtool.c b/lib/ethdev/ethdev_linux_ethtool.c
> index ec42d3054a..f508cdba6c 100644
> --- a/lib/ethdev/ethdev_linux_ethtool.c
> +++ b/lib/ethdev/ethdev_linux_ethtool.c
> @@ -17,8 +17,9 @@
>   *
>   * The array below is built from bit definitions with this shell command:
>   *   sed -rn 's;.*(ETHTOOL_LINK_MODE_)([0-9]+)([0-9a-zA-Z_]*).*= *([0-9]*).*;'\
> - *           '[\4] = \2, /\* \1\2\3 *\/;p' /usr/include/linux/ethtool.h |
> - *   awk '/_Half_/{$3=$3+1","}1'
> + *           '[\4] \2 \1\2\3;p' /usr/include/linux/ethtool.h |
> + *   awk '/_Half_/{$2=$2+1}1' |
> + *   awk '{printf "\t%5s = %7s, /\* %s *\/\n", $1, $2, $3}'
>   */

The commands in the comment never worked verbatim.

$  sed -rn 's;.*(ETHTOOL_LINK_MODE_)([0-9]+)([0-9a-zA-Z_]*).*= *([0-9]*).*;'\
           '[\4] \2 \1\2\3;p' /usr/include/linux/ethtool.h |
   awk '/_Half_/{$2=$2+1}1' |
   awk '{printf "\t%5s = %7s, /\* %s *\/\n", $1, $2, $3}'

> > > sed: -e expression #1, char 63: unterminated `s' command
awk: cmd. line:1: warning: escape sequence `\*' treated as plain `*'
awk: cmd. line:1: warning: escape sequence `\/' treated as plain `/'

Fixing the comment would be:
$ git diff
diff --git a/lib/ethdev/ethdev_linux_ethtool.c b/lib/ethdev/ethdev_linux_ethtool.c
index f508cdba6c..8a148ae0cd 100644
--- a/lib/ethdev/ethdev_linux_ethtool.c
+++ b/lib/ethdev/ethdev_linux_ethtool.c
@@ -16,10 +16,11 @@
  * and allows to compile with new bits included even on an old kernel.
  *
  * The array below is built from bit definitions with this shell command:
- *   sed -rn 's;.*(ETHTOOL_LINK_MODE_)([0-9]+)([0-9a-zA-Z_]*).*= *([0-9]*).*;'\
- *           '[\4] \2 \1\2\3;p' /usr/include/linux/ethtool.h |
- *   awk '/_Half_/{$2=$2+1}1' |
- *   awk '{printf "\t%5s = %7s, /\* %s *\/\n", $1, $2, $3}'
+ * sed -rn \
+ *   's;.*(ETHTOOL_LINK_MODE_)([0-9]+)([0-9a-zA-Z_]*).*= *([0-9]*).*;[\4] \2 \1\2\3;p' \
+ *   /usr/include/linux/ethtool.h | \
+ * awk '/_Half_/{$2=$2+1}1' | \
+ * awk '{printf "\t%5s = %7s, /* %s */\n", $1, $2, $3}'
  */
 static const uint32_t link_modes[] = {
          [0] =      11, /* ETHTOOL_LINK_MODE_10baseT_Half_BIT */


