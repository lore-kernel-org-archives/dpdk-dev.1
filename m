Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43746C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 06:14:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D65C402A5;
	Mon, 30 Jun 2025 08:14:21 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 32CBF40264
 for <dev@dpdk.org>; Mon, 30 Jun 2025 08:14:18 +0200 (CEST)
X-QQ-mid: esmtpgz16t1751264052t1b63034f
X-QQ-Originating-IP: W0ah4MHsDzn61Jjv2eM5zShw9X7W6hcOuUQHmSaugKs=
Received: from LAPTOP96V0OHHN ( [203.174.112.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 30 Jun 2025 14:14:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16731279733696166068
EX-QQ-RecipientCnt: 3
From: "11" <caowenbo@mucse.com>
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>,
	<yaojun@mucse.com>
References: <20250618121113.17302-1-caowenbo@mucse.com>
 <20250629104420.39505cf0@hermes.local>
In-Reply-To: <20250629104420.39505cf0@hermes.local>
Subject: RE: [PATCH v0 0/3] [v0]drivers/net fixed Coverity issue
Date: Mon, 30 Jun 2025 14:14:10 +0800
Message-ID: <09DA84041CD803F9+000e01dbe986$331f2450$995d6cf0$@mucse.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLmfBoH3BS3IgLUcKtVrjjavLGDvwISqDBxsfV7cqA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NFE/6V0PD07vTV0usSVSI59ZVjTGI8SySi5kb8n/84MimVIbor6WXhg0
 fsG+jS+YsF0nG6dZ6/PTY1ZhWFzjs7n22YU2NgysONffMnZTfsLFcfwr8B4A9cHyIe2DsH1
 XR6NTkb6dmvvdld6L0j3nGYdwkOVXhj5geFNXTuHkvpikt750RgEW8epIzkLrqVHlNzQ0ER
 3WPX9d9B3UsiAHTvVxufujTZV6ElPatdjem6HaIgfE3rJ9XN9c16n/tcycw1/EbBhve3C1m
 yqqzXDBxN7uaOII6HaL94Nm98IF5QngjwRr7oePTSXJiO2EtF2OTgMocfwWhfy3haMJVuIe
 KMxNTepkO7OBrSeDk0ypVuKHkxj2T4UnvasW+zF7MWkA2YMSLHXwrrGwh7g6NP3tKknlgn+
 JRi7NZ+vS6qWfHseFXhCzV5xPanLyO4RtSKjymO1VJQ2/LBpEBtY3xAQO7BhDEUuw2rIISX
 E7cjqnOboED4ujnlU9NKiFqnwgIdmkaUyH8qBaGRz7NSWAxXdPGk/BPzjmuSIl6dXrJArGr
 zsPTJXH997pSEejVmBxkMQGBbePVGO/I0bnL0an7E17Wo4Ri4ibf9QcRDPhzgMgM5JEHoSi
 7O5UO8Ru2K/EulxRE+yC1RJEngrmV5TDtUUujc+UdtyLaD+luQhZkqzWJz36o0xCQUyvXoY
 BBNfwU8wv7Sk9mKlwDHUV3uUsdptDGjMN0OnXAALyz7o4QY+wrOJN/eKuycSE3fQsyUthB6
 GZunofp5oXOWvuidv9qLnPCWiCrzGoAgW1wgWtvOr62mt9phtAoG5KjH0X7Gcpw9h1UNb0d
 AakdgEO3w2zheOSSxKUz8ahUflKmBnEW4xlq3CyVCp70TS1CChLIBKVJ3+yRIMEhz3JqlrF
 eNFBH+KsXSsUfVOXjtk5XTLm0tblOCXHrw99bcWXH/jzpU+hkqBQq0EOvuSa9kwcv7dREnt
 5ZS7wv9T15kBNZKA1LdBsM4+5hDGP/omzaFo=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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

Hi  Stephen,

Thanks for your guidance, I will submit it next.

Regards Wenbo

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: 2025=C4=EA6=D4=C230=C8=D5 1:44
> To: Wenbo Cao <caowenbo@mucse.com>
> Cc: dev@dpdk.org; yaojun@mucse.com
> Subject: Re: [PATCH v0 0/3] [v0]drivers/net fixed Coverity issue
>=20
> On Wed, 18 Jun 2025 20:11:10 +0800
> Wenbo Cao <caowenbo@mucse.com> wrote:
>=20
> > v1:
> >   *:fixed compile issue
> > v0:
> >   *:fixed the below issue:
> >   	Coverity issue: 468860,468866,468858
> > 	Fixes: 4530e70f1e32 ("net/rnp: support Tx TSO offload")
> > 	Fixes: 52dfb84e14be ("net/rnp: add device init and uninit")
> > 	Fixes: 52aae4ed4ffb ("net/rnp: add device capabilities")
> >   *:fixed 64k tso
> >
> > Wenbo Cao (3):
> >   net/rnp: add check firmware respond info
> >   net/rnp: fix Tunnel-TSO VLAN header untrusted loop bound
> >   net/rnp: fix TSO segmentation for packets of 64KB
> >
> >  drivers/net/rnp/base/rnp_fw_cmd.h |   1 +
> >  drivers/net/rnp/base/rnp_mbx_fw.c |  15 +++-
> >  drivers/net/rnp/rnp_ethdev.c      |  16 ++--
> >  drivers/net/rnp/rnp_rxtx.c        | 118 =
+++++++++++++++++++++++-------
> >  drivers/net/rnp/rnp_rxtx.h        |   1 +
> >  5 files changed, 117 insertions(+), 34 deletions(-)
> >
>=20
> Overall this patchset looks fine.
> Could you try out the suggest bit changes, and resubmit please.


