Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A66DC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 17:22:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8875340DD7;
	Mon, 13 Jul 2026 19:22:46 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 85E7D40DC9
 for <dev@dpdk.org>; Mon, 13 Jul 2026 19:22:45 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493f2e39e81so13268315e9.2
 for <dev@dpdk.org>; Mon, 13 Jul 2026 10:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783963365; x=1784568165; darn=dpdk.org;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2/5a7oiP029oXgf9ffb0/hV0017mjVjZWWKaHOB2NZ4=;
 b=ErXwHGAbm6HpFTh23BGYOjmWo6WZOkY2bat7I7al246CXjVOHoKt6dA3vU/6AOvsPw
 /2Ijsj0U2ZSdR5xxm41jsD6+0nk5EBqYiI3HBgp+icpV6EP75o9z1O/BAtocUryR7Oey
 QDqZ1Fc8bgIyqPycGudFgUqTW82vzSl7+S0poF9H2eN6lUjC7ffmy6ZbHsPuML8JxGPW
 WC97moKXJ+7kjEcCw2cgVwDfI/IhUYODnbwdS7FeLAqGsi8ghIJ07KsxlAftF9dYo/wa
 8505zACOXibcWYpe1E3gqdnLv2BU6wGfiVyJ7/EWL2ZkV5nmDgXqXLKK86XSkND23bri
 SkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783963365; x=1784568165;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2/5a7oiP029oXgf9ffb0/hV0017mjVjZWWKaHOB2NZ4=;
 b=GXp68Q/Icft38ojcX24oHRFB8KbBeIqYi800foazxqD9q6yjmrR27WQmaAMUPFQHxT
 Vdjikdpe5c2hlsNM6LFKrRSkpk+qs1x2ZQVV+x54LSAJWoD5GJdoUk+CVXiwttIjlQbs
 /rpa7ej6pFT6vBBKWdnpl6TznuUD8A2YjJbgrtQa9+JVuY0Z/Jb3/LayVCRlJEaDTn6z
 sDxeyk1Mc9NpPSQHix0xALAfizlOLt3tfZSBz9t/t5eOkn9NTjn/K69LEBHSBXRhV4YM
 eEINP+kCfIuapqDTzEg7hnpwIV4/dBKNv6DR6sUZXoAEBaD954f2tdx3PprKGcmxGJOX
 naxw==
X-Gm-Message-State: AOJu0YzldZqvNvlRD9tMCiNmol6a55jFa4vB3U42PRLWwF4bwFrLK7mb
 Nx5czHAqLiipoA5dgvT/LqICARf9SPfVx0eMbZY2QsDu3rc5lY2XcD23zjLWHjhN
X-Gm-Gg: AfdE7cn9su9xtmwj5S8pD7SjvijH+nJCRnXYN7iP+dFZelSzB898WYMSReH8l+eMBjq
 GJ2/v6Ef2Y+qXSxEFM6N6q6W1YBPE/5XLKCtHXmzrefLRW6sdwCXj1f3YrDdYtEjHgszqNQCmHv
 Ns8GAvsGnT2YF2D1UCpRcZvbfYiobTqBrHI0WtoZu8xC6MMuDy9ATbdKEmRdnj7tZvazm3PGorM
 kQLsKHPrUxQHMX0yH32x7W2CKo8EN0qK2AMST8iCesrn06YOYLuRa99kBtXEk7ym+JoluVhe6p2
 mNsGghZbnHx9WuExyqbqo8qDMNz4ECczdCgkayDyHgqx1nLLBqchfRhC2hfSRNqzgpyG0nk45/N
 XVeixiC5LcAvy57fMF3igu9QmeuE8DyXehRMws9Z34ynNf2xs2AbqSkli0fxRQOKz4kdbpbGb9u
 OBSeVj3ENuW7teCfJb73U2gCrbfxNd
X-Received: by 2002:a05:600c:a016:b0:493:f442:3de9 with SMTP id
 5b1f17b1804b1-493f883174amr101145995e9.27.1783963365052; 
 Mon, 13 Jul 2026 10:22:45 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:3bc9:8b70:b42b:658a])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47f464c4320sm795712f8f.32.2026.07.13.10.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 10:22:44 -0700 (PDT)
From: luca.boccassi@gmail.com
To: dpdk <dev@dpdk.org>
Cc: dpdk stable <stable@dpdk.org>, Akhil Goyal <gakhil@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Archana Muniganti <marchana@marvell.com>,
 Ferruh Yigit <ferruh.yigit@intel.com>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Jerin Jacob <jerin.jacob@caviumnetworks.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Ravi Kumar <ravi1.kumar@amd.com>,
 Siraj Luthfi Ananda <sirajluthfi@gmail.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>,
 Tejasree Kondoj <ktejasree@marvell.com>,
 Zbigniew Bodek <zbigniew.bodek@caviumnetworks.com>
Subject: please help backporting some patches to stable release 24.11.7
Date: Mon, 13 Jul 2026 18:22:38 +0100
Message-ID: <20260713172241.1709792-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
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
Reply-To: dpdk stable <stable@dpdk.org>
Errors-To: dev-bounces@dpdk.org

Hi commit authors (and maintainers),

Despite being selected by the DPDK maintenance tool ./devtools/git-log-fixes.sh
I didn't apply following commits from DPDK main to 24.11
stable branch, as conflicts or build errors occur.

Can authors check your patches in the following list and either:
    - Backport your patches to the 24.11 branch, or
    - Indicate that the patch should not be backported

Please do either of the above by 2026/07/20.

You can find the a temporary work-in-progress branch of the coming 24.11.7
release at:
    https://github.com/bluca/dpdk-stable
It is recommended to backport on top of that to minimize further conflicts or
misunderstandings.

Some notes on stable backports:

A backport should contain a reference to the DPDK main branch commit
in it's commit message in the following fashion:
    [ upstream commit <commit's dpdk main branch SHA-1 checksum> ]

For example:
    https://git.dpdk.org/dpdk-stable/commit/?h=18.11&id=d90e6ae6f936ecdc2fd3811ff9f26aec7f3c06eb

When sending the backported patch, please indicate the target branch in the
subject line, as we have multiple branches, for example:
    [PATCH 24.11] foo/bar: fix baz

With git format-patch, this can be achieved by appending the parameter:
    --subject-prefix='PATCH 24.11'

Send the backported patch to "stable@dpdk.org" but not "dev@dpdk.org".

FYI, branch 24.11 is located at tree:
   https://git.dpdk.org/dpdk-stable

Thanks.

Luca Boccassi

---
d84f4082f8  Stephen Hemminger crypto/armv8: use timing-safe digest comparison
752589fb45  Stephen Hemminger crypto/ccp: use timing-safe digest comparison
f72517b8e7  Stephen Hemminger crypto/cnxk: use timing-safe digest comparison
