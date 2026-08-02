Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9320FC55171
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:19:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB574409FA;
	Sun,  2 Aug 2026 20:18:56 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 485E740653
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:48 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c999f162c9aso1696562a12.3
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694727;
 x=1786299527; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w5mTKPHS4w46eawypqJSh3DMmTIUhPibq2qyf+2g70U=;
 b=OzUNy6PP7VRhQvUPYokOWPBFgL74E1Euv1TedJsoxrzJUnJ9Zuy1MMH/chclL0dNyU
 ltv1ZiUqKGd0eYzZy3f6Yt/vKISfLhQEz/P7gspSV8FZh3t4Q8eYFDgK+bRJJymSs6+z
 K3gM4ddErbU1kd0THShV0M62vjIRKQtkrwxqW6CJLU4sw3CUnd9eiHNWd06xtiSSUKEJ
 IXPLUOrA70PbCLCXhcdcXr6fXKF0Gl7u94fs4elr6SuQ/tpnrtUIbJmDkCHpcFnFQ9e3
 DzkdjZivJFT5y1ywWhRdOXUrvwR4vAHbBlocZJfvMzp3dF3cFKWESqPKjHMzkOKEDsHr
 77XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694727; x=1786299527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w5mTKPHS4w46eawypqJSh3DMmTIUhPibq2qyf+2g70U=;
 b=BZMCxR8w6v8ZX5+f9N1PTl6n77W1mwWu+q4buQ9B7RanCNbN0tfPrgdfVyCdnnImG3
 ApT2Tua6TBzZYEPOu1ZCRZk6rFeqAhpC1gOO5NWpVEEfiRd+U52uk2KqfHg7bVyQ2m5p
 s4AAMPFC/+F9cEJLqJ5jqAlouM+yUOhuass3LjXyWKN1atONWOzeem0rRL9vz/WcQ6rZ
 KA7kLHK32acurnHPBmm0I5EX3CUe51qJS+1SIAeckUR72toFRyi4F7mcZk4jxTtjlXRn
 CW5Za5Uny0citLLgvHCdSCNoqlXBtWnDHBBZzP9C8yd2MN5FTXP8qYJItlswLRx+kn9B
 KGmQ==
X-Gm-Message-State: AOJu0Yx3PHbdMP8KSF6RhntTb/bequpuKAoJtF++Y33MPnKt/FbGvanm
 Fxl91fpi4E+mMmuQpGsIuCj5GSzj9jOd4YtuLDAIVl8Muuk5JlYfWOtKVgEohXbHemUdHivvCHw
 tPSMD
X-Gm-Gg: AR+sD10OzNU5KXMjDMfq1Xp0BjKaJju7FEDafJPetdBwWSrdXZC47803V528R5tocI8
 4VehYzPze/1X4eBUMvvLJ3yqouS885G/7UZM/vLLBp8jTxlm6+jmFQ0jLqMeoVQFTSCNbSfjpze
 k4UT0iFQCp3kmW6gwdjHRTdV+fmRn4qnNixLEqxMPlRfaSNfp4r/mqHVCr5JKsXr1rfJHe0gyGB
 8V3OCrGvkDhaPH+jiosfoHdu/FPg5C2zjcnQy4WMFxK4Jgj+1qieTMhG0XTgTDc/T+yy47tISn2
 ADFeDpk9QLhs8WzliUovTlsH08LjsH/Qw0t2lnBSAi/YT1bgb3Flfs51ch6jeHFw5DOf1qaXkcZ
 v0oPVaHRQa25JEgxHrd6+ZUyDiYqeSVFGUNN54BcLthT0J4HOA1QwOsAVU5cez/4u0XW7OWODqh
 /sj7UwbVJ0zkl3FEgBgUgp0o8bFIKXPZAICDmba7CH3WcusLCSfDCAoGFkyselVs4GVMwZ95EIm
 fCk1LYmSxtj+nbqHVZVlgUuW+E=
X-Received: by 2002:a05:6a21:3390:b0:3c4:397a:69b8 with SMTP id
 adf61e73a8af0-3c92a749983mr6877836637.21.1785694727519; 
 Sun, 02 Aug 2026 11:18:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [RFC 09/21] net/mana: include used network headers
Date: Sun,  2 Aug 2026 11:15:14 -0700
Message-ID: <20260802181835.476887-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802181835.476887-1-stephen@networkplumber.org>
References: <20260802181835.476887-1-stephen@networkplumber.org>
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

This driver was getting definition of ip, udp, and tcp headers
implicitly via rte_ethdev.h. That will be changing so instead
include the required headers directly.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mana/mana.c | 2 ++
 drivers/net/mana/tx.c   | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index 0b72f711a1..3870cb4a52 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -6,8 +6,10 @@
 #include <dirent.h>
 #include <fcntl.h>
 #include <sys/mman.h>
+#include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <net/if.h>
+#include <netinet/in.h>
 
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
diff --git a/drivers/net/mana/tx.c b/drivers/net/mana/tx.c
index 10f2212b5d..9517b033dc 100644
--- a/drivers/net/mana/tx.c
+++ b/drivers/net/mana/tx.c
@@ -3,6 +3,9 @@
  */
 
 #include <ethdev_driver.h>
+#include <rte_ip.h>
+#include <rte_udp.h>
+#include <rte_tcp.h>
 
 #include <infiniband/verbs.h>
 #include <infiniband/manadv.h>
-- 
2.53.0

