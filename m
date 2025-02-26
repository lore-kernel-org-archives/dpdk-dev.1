Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B69CC021B2
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 01:40:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8478C402D6;
	Wed, 26 Feb 2025 02:40:25 +0100 (CET)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 7E567402B9
 for <dev@dpdk.org>; Wed, 26 Feb 2025 02:40:22 +0100 (CET)
X-QQ-mid: bizesmtp85t1740534016tk1q1jyg
X-QQ-Originating-IP: MP/Z/7nbrfOBabXK6d8eKwhBL0ccf78s/rUZCgGfa2U=
Received: from LAPTOP96V0OHHN ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 26 Feb 2025 09:40:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2362620114116528455
From: "11" <caowenbo@mucse.com>
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <thomas@monjalon.net>,
	<dev@dpdk.org>,
	<yaojun@mucse.com>
References: <1740472886-30411-1-git-send-email-caowenbo@mucse.com>	<1740472886-30411-10-git-send-email-caowenbo@mucse.com>
 <20250225080846.50657db8@hermes.local>
In-Reply-To: <20250225080846.50657db8@hermes.local>
Subject: RE: [PATCH v15 09/29] net/rnp: add queue stop and start operations
Date: Wed, 26 Feb 2025 09:40:15 +0800
Message-ID: <13605C9495387658+000001db87ef$635d1620$2a174260$@mucse.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE3cIsCI7fjvHU+Od3y8bHAFkApGQHWXVJSAlqCS+C0f3WocA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: M182XWJxg1fq6R74gs3iCIXqaxbk1EbSJyAgRSHgPvEylaAm29tc8dOh
 li65+CLtf9NBbc92mVDA+78IzQo1/ddB8KuN5bI/OlH5ro2bIbv881Cu167uwVYAsyVil0L
 r2bf4O4PDY2JCcGlRcBdxq8dutr0joHxKDL6jKBZHJZDtkpIAYx1BWluASxySyYvdZ8mLdG
 oNtA7PJK7DkliYPwQHkwPzKvP56Qs5iBnZdVAE0pEzwR6oBCz3wQxZa90YVIE56EHPf4/QX
 FPN2fdfZa21MMgMKMb0AIepRE5tWicmNGY7FUaIY5+nHiuLgd1Cj1AtziQNvSlLEZrt4/25
 m3+ok3IlCTKlPLrUaV5Pqpg2LC8ezVAxf6A61eN0hEHknQ0pAsCGt/rQWSZoXMrWa1POS5C
 feeo44kQagThNZ76ceCPiR00fhrm5zpzvCVuls1Mm8DzEaFpDHArMW4RpG/4LSUEDVN2R10
 nuJwXX1YMFRX+Pevbl9+I8+Gv1piddb3Ks0IDpAm6Ok9zanvxPMpGPDEpPfh6uN9QDutc7v
 oBEogwkb+weZ3NQe2sRPZSzW7Rm8whtBxyolE8wNcO56d7ZJ6ENnBdbj8ikoeAJG8UpLFmS
 LedINvGjpIdlAjukxNZA/4hYVSCmOBJIVLMsbJn/vIi53nOo7O5xL+Y5p8f5pPYh1I5XYZA
 7S3anNrkuq2CY4E8OQ5/IDL3Fx5tSAj4kFH/mpBrArCxB9mcvd384+uMy95wwglXU+NV9F3
 DEQK03R0VnjMbtUYpXg/76QBMgYLcE4DxBcseWeUkdicHFcjQrQVHNL9EhaBEGG9im4L5i+
 O+wx0B6ecN/B6iYUbMddj5PwTPXTIJ8vvXEAJ7IETdW8sKlbEmIuiwk15HTe5SWg9suXk97
 SH5zj6r5Ni1+IIsmyP/Ugku3w/r6MRtWxhA9JTrbCCbZp2gtjpcFH/7Qs5ZYYm+w
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

Hi Stephen,

I had been not added it to const struct eth_dev_ops  for
.rx/tx_queue_stop/stop :(
Thanks for your check

Regrads Wenbo
> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: 2025=C4=EA2=D4=C226=C8=D5 0:09
> To: Wenbo Cao <caowenbo@mucse.com>
> Cc: thomas@monjalon.net; dev@dpdk.org; yaojun@mucse.com
> Subject: Re: [PATCH v15 09/29] net/rnp: add queue stop and start
operations
>=20
> On Tue, 25 Feb 2025 16:41:06 +0800
> Wenbo Cao <caowenbo@mucse.com> wrote:
>=20
> > diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst index
> > 99b96e9b8e..c3547c38b6 100644
> > --- a/doc/guides/nics/rnp.rst
> > +++ b/doc/guides/nics/rnp.rst
> > @@ -71,6 +71,10 @@ Listed below are the rte_eth functions supported:
> >  * ``rte_eth_dev_close``
> >  * ``rte_eth_dev_stop``
> >  * ``rte_eth_dev_infos_get``
> > +* ``rte_eth_dev_rx_queue_start``
> > +* ``rte_eth_dev_rx_queue_stop``
> > +* ``rte_eth_dev_tx_queue_start``
> > +* ``rte_eth_dev_tx_queue_stop``
> >  * ``rte_eth_promiscuous_disable``
> >  * ``rte_eth_promiscuous_enable``
> >  * ``rte_eth_allmulticast_enable``
>=20
> There is no callback in this driver for rx/tx queue start/stop.
> Did you test this with test-pmd?
>=20
> If application calls rte_eth_dev_rx_queue_start()
>=20
> int
> rte_eth_dev_rx_queue_start(uint16_t port_id, uint16_t rx_queue_id) { =
...
> 	if (*dev->dev_ops->rx_queue_start =3D=3D NULL)
> 		return -ENOTSUP;
>=20
> The eth_dev_ops in rnp_ethdev.c does not contain rx_queue_start!
>=20
> /* Features supported by this driver */
> static const struct eth_dev_ops rnp_eth_dev_ops =3D {
> 	.dev_configure                =3D rnp_dev_configure,
> 	.dev_close                    =3D rnp_dev_close,
> 	.dev_start                    =3D rnp_dev_start,
> 	.dev_stop                     =3D rnp_dev_stop,
> 	.dev_infos_get                =3D rnp_dev_infos_get,
>=20
> 	/* PROMISC */
> 	.promiscuous_enable           =3D rnp_promiscuous_enable,
> 	.promiscuous_disable          =3D rnp_promiscuous_disable,
> 	.allmulticast_enable          =3D rnp_allmulticast_enable,
> 	.allmulticast_disable         =3D rnp_allmulticast_disable,
> 	.mtu_set                      =3D rnp_mtu_set,
> 	.rx_queue_setup               =3D rnp_rx_queue_setup,
> 	.rx_queue_release             =3D rnp_dev_rx_queue_release,
> 	.tx_queue_setup               =3D rnp_tx_queue_setup,
> 	.tx_queue_release             =3D rnp_dev_tx_queue_release,
> 	.rxq_info_get                 =3D rnp_rx_queue_info_get,
> 	.txq_info_get                 =3D rnp_tx_queue_info_get,
> 	.rx_burst_mode_get            =3D rnp_rx_burst_mode_get,
> 	.tx_burst_mode_get            =3D rnp_tx_burst_mode_get,
> 	/* rss impl */
> 	.reta_update                  =3D rnp_dev_rss_reta_update,
> 	.reta_query                   =3D rnp_dev_rss_reta_query,
> 	.rss_hash_update              =3D rnp_dev_rss_hash_update,
> 	.rss_hash_conf_get            =3D rnp_dev_rss_hash_conf_get,
> 	/* stats */
> 	.stats_get                    =3D rnp_dev_stats_get,
> 	.stats_reset                  =3D rnp_dev_stats_reset,
> 	.xstats_get                   =3D rnp_dev_xstats_get,
> 	.xstats_reset                 =3D rnp_dev_xstats_reset,
> 	.xstats_get_names             =3D rnp_dev_xstats_get_names,
> 	/* link impl */
> 	.link_update                  =3D rnp_dev_link_update,
> 	.dev_set_link_up              =3D rnp_dev_set_link_up,
> 	.dev_set_link_down            =3D rnp_dev_set_link_down,
> 	/* mac address filter */
> 	.mac_addr_set                 =3D rnp_dev_mac_addr_set,
> 	.mac_addr_add                 =3D rnp_dev_mac_addr_add,
> 	.mac_addr_remove              =3D rnp_dev_mac_addr_remove,
> 	.set_mc_addr_list             =3D rnp_dev_set_mc_addr_list,
> 	/* vlan offload */
> 	.vlan_offload_set             =3D rnp_vlan_offload_set,
> 	.vlan_strip_queue_set         =3D rnp_vlan_strip_queue_set,
> 	.vlan_filter_set              =3D rnp_vlan_filter_set,
> 	.dev_supported_ptypes_get     =3D rnp_dev_supported_ptypes_get,
> };


