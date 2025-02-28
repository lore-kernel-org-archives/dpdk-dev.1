Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B9AC282C6
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 22:03:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52D05410E3;
	Fri, 28 Feb 2025 23:03:17 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 75AF4410E3
 for <dev@dpdk.org>; Fri, 28 Feb 2025 23:03:15 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id AF134210D0EA; Fri, 28 Feb 2025 14:03:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AF134210D0EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740780194;
 bh=CnEC2JHqQeCEmkAKbf6Pz8/0YXuxtsHnyrSRqKZyJ8g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=geFDch2go+hl45D8GuDKZWPdjkBjt9SfkrJiW6tme20413FCA0WckXBD/NEb1yDJV
 HBeX0buKOUIWA+cWXhJXI0SwcPKhyZdVyimTW9ZkBvo0opN9fqMGWmimVRJVUWXQnN
 6QvE6epLWlqzigYJoWuhaMAbL+kkkvRJkCJQKZiU=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: bruce.richardson@intel.com, dev@dpdk.org, konstantin.v.ananyev@yandex.ru
Subject: [PATCH v2 0/1] move existing code that is common to the top
Date: Fri, 28 Feb 2025 14:03:06 -0800
Message-Id: <1740780187-5272-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740757940-10253-1-git-send-email-andremue@linux.microsoft.com>
References: <1740757940-10253-1-git-send-email-andremue@linux.microsoft.com>
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

In preparation to add better MSVC support, existing common code was
moved up.

A split was added which in future will call an MSVC specific meson.build
file:

if is_ms_compiler
    subdir_done()
endif

v2:
- removed call to get_option('cpu_instruction_set') from
  config/x86/meson.build as that call should not be done from here -
  cpu_instruction_set is already correctly set from
  config/meson.build. A separate patch was prepared to fix this in older
  releases.

Andre Muezerie (1):
  config: move existing code that is common to the top

 config/x86/meson.build | 90 ++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 43 deletions(-)

--
2.48.1.vfs.0.0

