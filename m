Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D66CD6E5D
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:50:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AAD84065A;
	Tue,  2 Jun 2026 23:50:34 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id A2992402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 23:50:32 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 2A8957A0079;
 Tue,  2 Jun 2026 17:50:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 02 Jun 2026 17:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780437032; x=
 1780523432; bh=vz/UcaUrpx+JTb+FJ3MoNOuCihSYTz37cH4yf5k+RRk=; b=R
 A7dTfvcMJqnJ3FyZW/sMUVl9Cr09ViklrtRGSyF4SRg8eZbjQvH9xqfp97Lu+l3p
 X00vnn2JNVBGCIds28lBF6ExwxvZKYR5cadZaGu+l4McmHACRhSTVZoHJO9xpubM
 Ej3MOBljZ9JP7XGxRRTLSS2eebtAvnv0SgH0sJrTLUmxkZvYTbbSDgs1AYoT04dZ
 /8lwPENruj3qk3HHi1Fpd/WoJ6CqOHpNJFZKd2jcMbeeh9YIYbRHH6wAB0LbwP5Q
 lfMfngKq1V6XUBqrX4yOQwL4//bjyHNbPNSwni8wegArUiLDdDtbC20w6IFEI4DP
 NHqq1YY+8h9uw3Zo0RK7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780437032; x=1780523432; bh=v
 z/UcaUrpx+JTb+FJ3MoNOuCihSYTz37cH4yf5k+RRk=; b=E4tdqnt+nRPOL2va7
 jyd6U10BKP4zXsp/AJwqCd74mH2s9epL6WlqZPzk6w2IvR1MXYzpYxNPeJ2YoZEJ
 KsbTMqC7sqThMZl5ydrWVN4thD7BNdNckOsJxxgYDxUIh/MmeRHRM7sn4xs+gnLl
 1WX2a6ISAQ7pRelhGZiDSsL6/OaqJP9oRjGjCsnAZBwPJiyxTiKNkjsuuYiePJi5
 DbmkHQwSJMfsIR+tKIiwUxl/rbGkY8LSbrtgANxtB9UikGsK9mj0TQjk2kiJn+9G
 dg7l4ZpiBBMqkc26eiWwkHuWpNZNBwd7q9irdIKBzXCdORzsuf6go8h4utVX+Cyw
 cChqQ==
X-ME-Sender: <xms:J1AfavU9WlrsqGKLj52u1kWX1OIl8sFGcbc0K6j5fJhMzXCcPTodLA>
 <xme:J1Afar5qir20AfQ3sHGnyqMJxKIFu8L5Z5DRfZjiPPYDk3R1h9eGzXNhJXo1MLRhn
 yBXI8OgsnsjPsIvyNESIjZEtYJ53A7HpBGA4RWbzAnCXWCeNfX0rg>
X-ME-Received: <xmr:J1AfaqjZkhbsO0Z9UGZpjPA0BrBe7VcOxfkVxvF_IEOmzqno2wIfzBaX8H29ycS-9q-MixKVKkuFQmh0k1bAQSTItbBnWj8>
X-ME-Proxy-Cause: dmFkZTGLViGudKsDyOQu7nlm3XZoPyesT9J8ZxOjQv8yq/MS1wAtj7j/V43Ic8lLIHpkM6
 u24csRGGOkjs/xNroLPu8HoNMq3e+8KP1NdqdSASIoO1axjHcjiZOnVqcJ07F1Hjk3y36h
 cOeSppG+igu2yT5H7V4wx+FFyjv+hJThrxxIWnTfg+f53qnusY+JeNkBxIBphEIWRawUW8
 ZOckHyfoXvSira7ocBEEgW0JlZI/VwLw1KxI16ukL54AOtHUKBt6rrwo13xrAhPxd4duBh
 nuMJPl5ZZJ3y7Z1atoozu4BpCMZ49HNleOgNEFAuqdsKfKkox402xD1lavnWn5WRw4/fTU
 Ht7mw+MeL52Jh9Z1ElEtv98LZ4XDmL0cA/Jwg08ZUAX6mS5xWxj0KZQRULGXEHSEtsSru/
 otbMIKw7WGiVN3fTo4rZNbUPCRt6DGiwC4ALbSMQgprPVN6ANs/EjXVy5uytTT6sNJ3INy
 OAkPHFyiwTQKGARvx2zv/yBr1tgYsNlScnBYkhj9wnzXX+CAC5mLrEg2TGiM7J7YhtVrKv
 0LYtk907jsGSd8pPLFS42Ry8sezKYOu8jbG57qS4nm13LryZJgITujop2JHjQpXFialgk7
 Q+cquQiDAQgcE7wkhrNlFmIC8Bl5xNvCtqp5706K3/tC2g2KkRUr/qemfwwg
X-ME-Proxy: <xmx:J1AfaieUxZSNgS8QfEA3MeG5XQE5fuqshqxZOF9aWLOKT41A15cHjQ>
 <xmx:J1AfavcmrXWVBY1bLzRBOj2M9_PmtnzwC8Tpi6EIUTCOmYZCTzWHlw>
 <xmx:J1Afas8EOrLta0T_1LXgLQkbJGitxHxPLh2DQMKTy1I2xlg03b2Z8A>
 <xmx:J1AfarmBO14HQO-vOT9ppGSkTc337rkshQONm6Wf-uTUoqXjSk2tnA>
 <xmx:KFAfapytla7pGTF1dmwrK4Z3D2vApXrSkzlPs0-n5jMEFzxLYndzHXtQ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 17:50:31 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v6 01/10] app/testpmd: print Rx split capabilities
Date: Tue,  2 Jun 2026 23:49:13 +0200
Message-ID: <20260602215022.3698662-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602215022.3698662-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260602215022.3698662-1-thomas@monjalon.net>
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

The capabilities from rte_eth_rxseg_capa are added
to the command "show port info".

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 app/test-pmd/config.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index c950793aaf..55d1c6d696 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -790,6 +790,12 @@ rss_offload_types_display(uint64_t offload_types, uint16_t char_num_per_line)
 	printf("\n");
 }
 
+static void
+print_bool_capa(const char *label, int value)
+{
+	printf("%s: %s\n", label, value ? "supported" : "not supported");
+}
+
 void
 port_infos_display(portid_t port_id)
 {
@@ -911,6 +917,16 @@ port_infos_display(portid_t port_id)
 		dev_info.max_rx_pktlen);
 	printf("Maximum configurable size of LRO aggregated packet: %u\n",
 		dev_info.max_lro_pkt_size);
+
+	printf("Rx split:\n");
+	printf("\tMax segments: %hu\n", dev_info.rx_seg_capa.max_nseg);
+	if (dev_info.rx_seg_capa.max_nseg > 0) {
+		print_bool_capa("\tMulti-pool", dev_info.rx_seg_capa.multi_pools);
+		print_bool_capa("\tBuffer offset", dev_info.rx_seg_capa.offset_allowed);
+		printf("\tOffset alignment: %u\n",
+				RTE_BIT32(dev_info.rx_seg_capa.offset_align_log2));
+	}
+
 	if (dev_info.max_vfs)
 		printf("Maximum number of VFs: %u\n", dev_info.max_vfs);
 	if (dev_info.max_vmdq_pools)
-- 
2.54.0

