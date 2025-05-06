Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82969C3ABBC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 17:40:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E00140261;
	Tue,  6 May 2025 19:40:58 +0200 (CEST)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id 255364025D
 for <dev@dpdk.org>; Tue,  6 May 2025 19:40:57 +0200 (CEST)
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4ZsQfb0W54z3Q94;
 Tue, 06 May 2025 17:40:55 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4ZsQfZ3cZyz3wsk;
 Tue, 06 May 2025 17:40:54 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1746553254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=I9h1ZjVFWZSTQ3HlVpXfEMMtSYdlugwBNWe0hE7RzQg=;
 b=T8X1EowEMjJv7Ydfik8diKfU3g8iG9ulCxe49CRlKj8deeXihW2yLAgVzXEl/jCjvwMbU3
 fq+TX3ejzAF+6GPawhdSJ8VXpzmaRYeqVwZjRwbWCxUcqypsSOosbzEOEqCPf2OpJ9BgyC
 BWBT8zKfbVHEeMmytIbb/gkH8DRTZALV3PHovPTi5Bt2gVkjwx4AYbJIVHgfht7I+1Su0f
 RlIzXAjDW1CAmVJlWVeiy13JuoCzDxQrzr4KaH3qTpHVjqPkOXKe7VWZNXBKL7I1yf8Sg2
 tJJLtNoKtwun9ZlNktiArPrkgetW5z1arD1qJMBA1oyXucqxrcAxs6jZ+t7waA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1746553254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=I9h1ZjVFWZSTQ3HlVpXfEMMtSYdlugwBNWe0hE7RzQg=;
 b=BBABsiL3vlMFR8nMkAoIC/yaa1SSfUp8tG/ZBDQ0DRQx3bFxWaHV640QultFjzVzI9g7yA
 hMyICWzsQbw3C6oxZJE3smYdwgNhk+RvrdGaZQS+23aD1LofuIRmjkWBslhZ3UXv+mSuUZ
 eMiipdOLRY2iYCuoUiLlxVUzkUPNOGySxSAf3yj9IUz7NHdyvSzya0SNdDY29VexJhFsBR
 w9J4k07rcd8Hwk9gUyj4p6tuQ6UpBlYIYBi3GIwdsdn86oF2eHn9NfLoSAsvGouWk/NmNc
 jy+HnLNNdmnXnaWt/H9h24wi+ZNUF6Ig7Ly0OI8pfjko26E6V8mTEtDfgaNqhA==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1746553254; a=rsa-sha256; cv=none;
 b=EHEi3z93nSAlB3Q7afnupR7BwsvCQSZ5QMp7YFLo/fR/bhqdRCFroSnhu6Zs3Iwi8LT1QS
 ZFHdIP+08UdpuX0k9tLhWQSKN8VKl8wCXkdFQ1jDSMKUDh7ImHofmXSdzxr2Ti99I4S4vL
 bFUjteL4XR77ed1yYabU5jbwhDEL5mEKVWu3Y25t7mbnwsIFVF426yJ3R+v+3vXdrmfzEX
 sxqOAA8RPx2Sf3QSVwX1HLr3co69+LvDB5wamVF3iH5AQqNYtewYeX8XGM9N4eOCQt8y8W
 Sv9lR+Uhxl0EgJoKwd+RpASDC8E1GerbV0T3YO9vF1QVcHQKppsRHEux31OT2Q==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from s1.pct.niksun.com (67-4-147-206.mpls.qwest.net [67.4.147.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4ZsQfY2nCkzvHl;
 Tue, 06 May 2025 17:40:53 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH 0/4] BSD PCI Fixes
Date: Tue,  6 May 2025 12:40:40 -0500
Message-ID: <20250506174046.1136711-1-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.48.1
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

Hi there,

The following patchset includes a number of fixes I've made over the
past year relating to the PCI driver. Most of these changes target
the FreeBSD platform.

Let me know if you have any feedback. Thanks.

Jake Freeland (4):
  bus/pci: Use force-noreplace flag when mapping PCI resources
  bus/pci/bsd: Map resources at EAL baseaddr
  bus/pci/bsd: Eliminate potential overflow
  bus/pci/bsd: Fix device existence check

 drivers/bus/pci/bsd/pci.c        | 32 ++++++++++++++++++++++++--------
 drivers/bus/pci/pci_common_uio.c |  4 +++-
 lib/eal/common/eal_private.h     |  7 ++++++-
 lib/eal/include/rte_eal_paging.h |  7 ++++++-
 lib/eal/unix/eal_unix_memory.c   |  8 +++++++-
 5 files changed, 46 insertions(+), 12 deletions(-)

--
2.47.2

