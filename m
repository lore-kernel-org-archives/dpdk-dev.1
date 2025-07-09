Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2B1C83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 09:14:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 923B7402D7;
	Wed,  9 Jul 2025 11:14:26 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 4DDA54021E;
 Wed,  9 Jul 2025 11:14:22 +0200 (CEST)
X-QQ-mid: zesmtpsz5t1752052453tda67bfbb
X-QQ-Originating-IP: Va4ob1h9WC0KsiredNRRD0Pe19uyWFCnI4YJMbd1AFg=
Received: from LAPTOP96V0OHHN ( [203.174.112.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 09 Jul 2025 17:14:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6884523226266969788
EX-QQ-RecipientCnt: 5
From: "11" <caowenbo@mucse.com>
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: "'Ferruh Yigit'" <ferruh.yigit@amd.com>, <dev@dpdk.org>,
 <yaojun@mucse.com>, <stable@dpdk.org>
References: <20250630055753.35445-1-caowenbo@mucse.com>	<20250630055753.35445-2-caowenbo@mucse.com>
 <20250630080710.09047543@hermes.local>
In-Reply-To: <20250630080710.09047543@hermes.local>
Subject: RE: [PATCH v2 1/3] net/rnp: add check firmware respond info
Date: Wed, 9 Jul 2025 17:14:12 +0800
Message-ID: <8563F4F4266B2506+000c01dbf0b1$d6d73fb0$8485bf10$@mucse.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMBs9PQyDdm79hZr8KApoz7CO4sjgIFIbDqAnmHxSKxugWaIA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NzSDQCFWCzVTZ7qQwNzcnihoMuzFaxYrnhxS2HdrIqj8K6+sB6gy6ghm
 MstxQE97ibLjm/xS+4Kthaczs2ix1FK4ORwALUh6xHp3M9wge4QJhl3iCAdxEvPGvTuHdIT
 ahBGyrH+Rx9S9qD3Cp2XEC0lB9q3rinwkacivuz64Ryq+q5o9K5f1/Ibx6UKEltGwteq1aT
 fww3SAlLjJ7Ggy7o2BXVZ7keDEGR61cujoeqbGPdKxyjUS77D6lGTEQrwoRdshBdii8XziX
 rDEZXvocBKd5gMtkOlzuwnRI64oS3jbdM9nxeiFXT2RLUteExdWRGQN+SiN25MC44LLlffQ
 WbnXrWdcvT89euMHEdBR69OiPDQ0ywU8ucHupBvaz+Tr1i/FkOErtd7rugrxpICOx7gsIn3
 pqr2SSUK40GzhLqUNP9osTr77Wj3iPTVj00wFWPocrEVl0own9Yd01UgXbosIQ+fC8IJqjk
 zn6QMWh9xLRAgYub4YNTQuYzVTrsCL2jS6VpZWZ0Cxha+aoRyln1OAAcWF2zw6jdv1TEXUT
 t8U43bcLDNHyAmMODBXpqLBexribkXaCOZZ5qYrBvnnMlrIyDuEZt9W62kQPW8kAu0m/ayZ
 9fH7ZqjnNQjY+JZ9FhnM6NRbPiAIUHJlRJRQrZrhhFniKwNPEdD8QalyuOsW0e7p2Yuo6cL
 6ofQdpys9ygjNAcHMxJ19uVobtuwaY9qmZs9u2gW6RPmUUs04Jys0rGwxrjC4PF2kvJBiOu
 8n6/pYCPcGINx3d+YnTiIILac9FJvLJfTo213XOEgxsIG9dJH/dCDpkyXQgiIMkNwNl/d7L
 /2Nv2opatRwknkhAhBnpiGlvh3gqQIjG8caSpxaJ7Pe0eJm1f47enEDpA8ACocP6/KOQCGq
 pwstrN055S6YpKzgufsG1Yf0FS/P6cpUTP01W1Je5yQgN5CRfND+JZL6BBth1U8MBXVQPiw
 rXjEg6br5Gd95dnSm/RnIngaY
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

Hi Stephen,

Thank you for your review. Regarding the changes to the rte_bitops API,=20
should these updates be implemented in V3 or deferred to the next =
release
version?

Regards Wenbo
> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: 2025=C4=EA6=D4=C230=C8=D5 23:07
> To: Wenbo Cao <caowenbo@mucse.com>
> Cc: Ferruh Yigit <ferruh.yigit@amd.com>; dev@dpdk.org; =
yaojun@mucse.com;
> stable@dpdk.org
> Subject: Re: [PATCH v2 1/3] net/rnp: add check firmware respond info
>=20
> On Mon, 30 Jun 2025 13:57:51 +0800
> Wenbo Cao <caowenbo@mucse.com> wrote:
>=20
> > Add logic checks at critical points to detect potentially illegal
> > firmware information, preventing subsequent logic exceptions.
> >
> > Fixes: 52aae4ed4ffb ("net/rnp: add device capabilities")
> > Fixes: 52dfb84e14be ("net/rnp: add device init and uninit")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
> > Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
>=20
> >  int rnp_mbx_fw_get_capability(struct rnp_eth_port *port)  {
> >  	struct rnp_phy_abilities_rep ability; @@ -252,17 +253,29 @@ int
> > rnp_mbx_fw_get_capability(struct rnp_eth_port *port)
> >  		hw->nic_mode =3D ability.nic_mode;
> >  		/* get phy<->lane mapping info */
> >  		lane_cnt =3D rte_popcount32(hw->lane_mask);
> > +		if (lane_cnt > RNP_MAX_PORT_OF_PF) {
> > +			RNP_PMD_LOG(ERR, "firmware invalid lane_mask");
> > +			return -EINVAL;
> > +		}
> >  		temp_mask =3D hw->lane_mask;
> > +		if (temp_mask =3D=3D 0 || temp_mask > RNP_MAX_LANE_MASK) {
> > +			RNP_PMD_LOG(ERR, "lane_mask is invalid 0x%.2x",
> temp_mask);
> > +			return -EINVAL;
> > +		}
> >  		if (ability.e.ports_is_sgmii_valid)
> >  			is_sgmii_bits =3D ability.e.lane_is_sgmii;
> >  		for (idx =3D 0; idx < lane_cnt; idx++) {
> >  			hw->phy_port_ids[idx] =3D port_ids[idx];
> > +			if (temp_mask =3D=3D 0) {
> > +				RNP_PMD_LOG(ERR, "temp_mask is zero at
> idx=3D%d", idx);
> > +				return -EINVAL;
> > +			}
> >  			lane_bit =3D ffs(temp_mask) - 1;
> >  			lane_idx =3D port_ids[idx] % lane_cnt;
> >  			hw->lane_of_port[lane_idx] =3D lane_bit;
> >  			is_sgmii =3D lane_bit & is_sgmii_bits ? 1 : 0;
> >  			hw->lane_is_sgmii[lane_idx] =3D is_sgmii;
> > -			temp_mask &=3D ~RTE_BIT32(lane_bit);
> > +			temp_mask &=3D ~(1ULL << lane_bit);
>=20
> Rather than using ffs directly better to consistently use rte_bitops =
which
has
> rte_ffs32().  You can address it in a future version.
>=20


