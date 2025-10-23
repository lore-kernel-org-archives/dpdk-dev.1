Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31E9CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 12:14:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC429402EB;
	Thu, 23 Oct 2025 14:14:36 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 3D237402C3
 for <dev@dpdk.org>; Thu, 23 Oct 2025 14:14:34 +0200 (CEST)
X-QQ-mid: esmtpgz12t1761221670te786c79a
X-QQ-Originating-IP: ohcV11M0WcgyFs8O15lC0dHLJq2Wfg1Ryn73en6avPY=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.187.129])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Oct 2025 20:14:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10114263378093311094
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH 1/6] net/txgbe: add Amber-Lite 25G VF IDs to PCI ID map
Date: Thu, 23 Oct 2025 20:13:50 +0800
Message-Id: <20251023121356.21944-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251023121356.21944-1-zaiyuwang@trustnetic.com>
References: <20251023121356.21944-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MDs/gHBQyPmhVLsRX0SyXXFFkiGO21RxQQcWIDXmCMEHifE0cmJX+8e1
 cNE5Kw8VHzLbi8C1UZXf7VDPlzFOJvPSFlXORRPT7OyUD6j5N2eofIyp0efpT9dbR3zE2hq
 4ReDizWgqCK3A2M+SdUBElOlBM7fdLciMuj5+MAcBnNhWB+QWJhbGU6Frv27WFgmbBVpsB2
 Aypv6M2hG3VDX/ShFxqTsF4oXDIc/Ik251wfM8HlRUFl2p3qXomDfm2fcF8VUl5DZ+qzi+3
 BqL0insDUBhaSlw1NTZpUdqk+w8ztEaUsqDlsBBa19kcrxBrugo+7nuIvIqozy5vLlZtGHu
 gspNu9nunQnRNHCSlII+VkOTgwX8e9kVK8lAHijibG4Q0tUdbXQ0kUtSnoSith0wByRTQaC
 vRQD9pXUJr1ivQfm3wv8DIeQX/bS/6LWpHEI2ctBpxfPGM9l6DTbxeMDmZyaENCogX2mvjx
 gMx6x2dLPlNjqSkjzX1zjiothifxYmTEOstqO7CmBA5dFgFUZCjkpO90hMZ5TEilOPRMEok
 79FlrcB4vHlWY+pKaEkVQ0zo+AMfd5Nchx+79t0tRYC8flKYEPbQwz0t83ePLL00DioZADw
 M/SbzWHh+GZHLBVlnjU4KFlky/o/Su1NHSL0EeVWaJJmaIYp5JmTe4DgrclapJVgATG+NWY
 NObbQHeQux/aF4gMidMcwixIKxSKtbgRb9cYd34VsS1qr9XMCyVDoEqE1l3atHhVqvUGa6C
 iTFslKv7Evz/rBGdDLf+2DV4hYG3lNKRCo7Wr0o/7elkjk6lKdmhm5GPDD1rMSeCMLzlfww
 mumRPJ2QIhvV9kv6nyZDPqbDSm1BcDScnq5Thpgs1xtP38qVHUiP+BEhFoUt+pZayR5ikpo
 I76jQdskpkDWVsZxxsqafKeZwUrVvAd+3sdwz6vWABYZJ2dw/P1YBcxn2sn6uTQ+tiEYRle
 x2NJghNwX9wHZPAXkYy+sdCn8BZFU9przjctoyhbIhdobZbkTbemJX5mdjlIvgPNC+IHk5w
 UFzsaKJfbqU3AxNsONQGetZH895oiF5wZ0rhTwMPNWMfHbrwBpoA+1nhaxkJE=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
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

Add three Amber-Lite 25G VF device IDs (0x5001, 0x5024, 0x5124) to
pci_id_txgbevf_map for proper device recognition and driver matching.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev_vf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index 4be7c5d659..9d0a858d4f 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -74,6 +74,9 @@ static void txgbevf_dev_interrupt_handler(void *param);
 static const struct rte_pci_id pci_id_txgbevf_map[] = {
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_SP1000_VF) },
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_WX1820_VF) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_AML_VF) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_AML5024_VF) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_AML5124_VF) },
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
-- 
2.21.0.windows.1

