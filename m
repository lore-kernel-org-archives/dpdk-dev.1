Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAA0103E2EB
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 13:33:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03EF74066C;
	Thu, 12 Mar 2026 14:33:17 +0100 (CET)
Received: from 2.mo508.mail-out.ovh.net (2.mo508.mail-out.ovh.net
 [5.135.90.177]) by mails.dpdk.org (Postfix) with ESMTP id 193B0402E0
 for <dev@dpdk.org>; Thu, 12 Mar 2026 14:33:16 +0100 (CET)
Received: from DAGFR7EX1.OVH.local (unknown [10.109.254.93])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4fWpTl63GVz7tGQ;
 Thu, 12 Mar 2026 13:33:15 +0000 (UTC)
Received: from laptop1704918.desk.int.gns.ovh.net (109.190.254.56) by
 DAGFR7EX1.OVH.local (172.16.2.20) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 12 Mar
 2026 14:33:15 +0100
From: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <xavier.guillaume@ovhcloud.com>
Subject: Re: [PATCH v2 3/3] net/af_packet: support jumbo frames
Date: Thu, 12 Mar 2026 14:32:48 +0100
Message-ID: <20260312133248.3435717-1-xavier.guillaume@ovhcloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310163158.4832e4b1@phoenix.local>
References: <20260310163158.4832e4b1@phoenix.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.190.254.56]
X-ClientProxiedBy: CAS1.OVH.local (172.16.1.1) To DAGFR7EX1.OVH.local
 (172.16.2.20)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 13878686679899844977
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGENQPgPNs8kxb1x/WdIPZ2+ZaKLoUQ9/Upc2spsGSGjJXrz9/E+NmDRf7jRecKeEmdIU6HZpjPeOpSinova6peDRyI70P8x1sZGK/XEXxf0QS0/mqVfFPhrNx8Fokl7hG+mNHbMkHxyJ89mJw5pJ3bqBW+UwUC3MJD4eHN7rZYPq/q6x/AdPMki+9isnLV98TnybFsE610I0Ducr80gEGT+6ET4Ibf7Qa5uB55TY66r60Ofk+PYxC+N1zaAqS6Xr6tk9X7jwOx16oRrqyv19y7x1T3+i7rEW2KJQLI6tAwhbFeM2Tu9n3XLwVF39DbrcJ+ootBKpCgHsVxWgpG8YJIN4TVt1SyrOh03a0+IsrSFznF0wjbYnX5p/Gb14vaY/dcDXyH2tmEnUUDcbBfClBd8YyMKz8/r+sxIpb2k3KB26Jhe8teACmqddSFexofoKKbFTkG1e4Rvl2/yklQrQukcqaoQeT01TrlEBcNBaGU4MTCxWzMYBIHu3MKS5KdIrD6LjMnCpqaodpw9YudZw/v2BAtr88tnoKGiQz2jELZ7W/X6H4V0eEmv5Vf43Bh+uTZ9vkQpO0f8uQGvRUlbWjji2mAOB2IXnpunT6viFG4d2U/Ojps88Ar3Cfk2oBdZgvOwIFoIW1cgmUjSD13KGYNT2hQy+6ih92GMGm2jTo3cA
DKIM-Signature: a=rsa-sha256; bh=W5oAcY0fj2/AnKVZjJ2BwUJZeA1KJHHMIvzPrgTHkE0=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1773322395; v=1; 
 b=f3KoVJp0UagjOqrkZ1a3OMHS82C5is1tZmBTMgFrVfenIGaItUdKMaIBLMqGO8bvFD6Nyy7m
 vDPJO5DvzZjt6K5gMMXnANOScWbYjLV1hIBooS8yuovGspaZAvRjJKbqBvb6/NHXu/dLgfaFfOB
 R9YXo5wtw13ybdpj6fNZQKZM=
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
Reply-To: xavier.guillaume@ovhcloud.com
Errors-To: dev-bounces@dpdk.org

Hi Stephen,

> I wonder if TPACKET header could go in mbuf headroom.
> And also, could the copy on receive be avoided?

Thank you for your review and the interesting questions. I had not
considered these angles, so I took some time to look into it.

As far as I understand, the current RX path copies the packet data
from the ring frame into an mbuf so that the ring slot can be returned to
the kernel immediately after the copy. This keeps the ring available
for new packets regardless of how long the application holds the mbuf.

Going down the zero-copy route would introduce a strong coupling
between kernel-managed ring frames and DPDK-managed mbufs: the ring
slot could not be released until the last reference to the mbuf is
freed, which risks stalling the ring under any buffering.

Because of this copy and the resulting decoupling, the TPACKET header
does not need to be carried into the mbuf at all. It is only read
for metadata (packet length, VLAN, timestamp) before the frame is
released back to the kernel.

In this context, my feeling is that the introduced risks outweigh the
gains (the memcpy looks relatively small compared to the full kernel
networking stack af_packet goes through).

Did I miss something?

Regards,
Xavier
