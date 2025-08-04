Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8A3C87FDA
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 06:51:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 228864025D;
	Mon,  4 Aug 2025 08:51:31 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id C5C03400D5
 for <dev@dpdk.org>; Mon,  4 Aug 2025 08:51:28 +0200 (CEST)
X-QQ-mid: Yeas2t1754290278t505t22059
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [60.177.96.13])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 8988537795061575520
To: "'Zaiyu Wang'" <zaiyuwang@trustnetic.com>,
	<dev@dpdk.org>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250625125047.18072-1-zaiyuwang@trustnetic.com>
 <20250625125047.18072-6-zaiyuwang@trustnetic.com>
In-Reply-To: <20250625125047.18072-6-zaiyuwang@trustnetic.com>
Subject: RE: [PATCH v2 05/15] net/txgbe: add support for PHY configuration via
 SW-FW mailbox
Date: Mon, 4 Aug 2025 14:51:17 +0800
Message-ID: <073501dc050c$2da55a70$88f00f50$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKiC98C7jrCga9wsmi8xZSIVafTeAFw0qYVANyi+YOys5GXsA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MqjGdKQeE31Xc0RUNeCiaKXisbItzVSu409OX32Gs4Ib/qsesMyfNxkA
 ToEeKuoU2R+OnMTETtSiuZM1sTIPRbR/pLPVtuzVGovRo23NBz3MBlbHUZMTCoHCPsbTypq
 MZUUeaTGy/kEGJooeWt1j+wPmYftrCS8Ucr9VgdO31BKTQRr9nCBUunXmhzxLQOH+tW02qP
 2u16aqCIjk2Pvz4bA9Sk/mVaKJlrMeDuk+hCZoBY2SAhgViOUnuf4I2VbnrZdoCkO7qSXfF
 7anUI+7nZDTiv7K56w8hlOJFOsIZf2IUZxZX30kciLJfaudXgC+zbPySNy3prmYoQ6pfmgi
 kYACAMQA+I6Xhd3HaNKLzEDFhqEMXdPkJ0/dn9byZpiqCIgsPSZln20MUHbAOaQi44i3CK+
 /SManBl1QajGIbuKLtTHv9y7W1Lk2PFi4GZynAFbch7tb8sP+uUfBOyQfjGo/TbML3rlkE/
 nfgLhjuGo0HDgsZlfLQwUrMCtWhiPwSFGBTpbDbWJQhS7tiChlHeBZCl6pUT94tQwK/pCgt
 b+WMuI6MxtWJPXUqNj34994yxKn7ayWfmGpC8XLdwcBkueI4dyuI9F3CWBcRT2Kq6xpKh31
 MbFpdV8w/9impgMxt9K5iklD8x6OlgRSioPgdNcuNole8c08jlfTEkoFj5toPlmNE0L/P2S
 OJiq8RrW4cUBQ3thMMn7MmWX7HESTecDGSjKFINqhL/7V+vJZ97miOTD5CgGy0rJSh5Jp6l
 l2E9IMhIdl5uQZQrXYY9eFlzA3rdtpQUPy0tzZ6h/YhZeIGrMDHuTYlwg4NIOgp+1TNAPgx
 0rP+SRqpAWxI9tu0dGSMNLf/jcZENipelFmFWG7FpHp+SnYLJ5h1yTyrk5ErpEeyreZ9wI6
 y5NYBJmUD0JLhJUvvzzAs28omPAb5R0aboHulK1+5G/fW+gt9x5IT0ScEOSRNTWR45BQai+
 E+hdEcfNP0WpgK0nf7rLq42HcxV3XP5mAUscRWwmW0DUTP5hAN8OOQq9lg5r9xSGIl4PhS9
 pR3pXDROuGrFpDBSZe
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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

> Subject: [PATCH v2 05/15] net/txgbe: add support for PHY configuration =
via SW-FW mailbox
>=20
> Migrate Amber-Lite PHY configuration to firmware due to complexity.
> Driver now sends mailbox commands for link state changes, handled
> by firmware=E2=80=99s intricate PHY setup process

This patch removes what was added by the previous patch.
I don't understand why. Why not simply merge these into the
previous patch. Or just configure nothing there.

And...

>=20
> Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> ---
>  drivers/net/txgbe/base/txgbe_aml.c   | 52 =
++++++++++++++++------------
>  drivers/net/txgbe/base/txgbe_aml40.c | 37 +++++++++++++++++++-
>  drivers/net/txgbe/base/txgbe_hw.c    |  1 +
>  drivers/net/txgbe/base/txgbe_mng.c   | 36 +++++++++++++++++++
>  drivers/net/txgbe/base/txgbe_mng.h   | 17 +++++++++
>  drivers/net/txgbe/base/txgbe_type.h  |  7 ++++
>  6 files changed, 126 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/net/txgbe/base/txgbe_aml.c =
b/drivers/net/txgbe/base/txgbe_aml.c
> index 1b5a3783a9..510a539d38 100644
> --- a/drivers/net/txgbe/base/txgbe_aml.c
> +++ b/drivers/net/txgbe/base/txgbe_aml.c
> @@ -131,21 +131,37 @@ u32 txgbe_get_media_type_aml(struct txgbe_hw =
*hw)
>  	return media_type;
>  }
>=20
> +static void txgbe_wait_for_link_up_aml(struct txgbe_hw *hw, u32 =
speed)
> +{
> +	u32 link_speed =3D TXGBE_LINK_SPEED_UNKNOWN;
> +	bool link_up =3D false;
> +	int cnt =3D 0;
> +	int i;
> +
> +	if (speed =3D=3D TXGBE_LINK_SPEED_25GB_FULL)
> +		cnt =3D 4;
> +	else
> +		cnt =3D 1;
> +
> +	for (i =3D 0; i < (4 * cnt); i++) {
> +		hw->mac.check_link(hw, &link_speed, &link_up, false);
> +		if (link_up)
> +			break;
> +		msleep(250);
> +	}
> +}
> +
>  s32 txgbe_setup_mac_link_aml(struct txgbe_hw *hw,
>  			       u32 speed,
>  			       bool autoneg_wait_to_complete)
>  {
>  	bool autoneg =3D false;
>  	s32 status =3D 0;
> -	s32 ret_status =3D 0;
>  	u32 link_speed =3D TXGBE_LINK_SPEED_UNKNOWN;
>  	bool link_up =3D false;
> -	int i;
>  	u32 link_capabilities =3D TXGBE_LINK_SPEED_UNKNOWN;
>  	u32 value =3D 0;
>=20
> -	UNREFERENCED_PARAMETER(autoneg_wait_to_complete);
> -
>  	if (hw->phy.sfp_type =3D=3D txgbe_sfp_type_not_present) {
>  		DEBUGOUT("SFP not detected, skip setup mac link");
>  		return 0;
> @@ -165,30 +181,20 @@ s32 txgbe_setup_mac_link_aml(struct txgbe_hw =
*hw,
>  	if (value & (TXGBE_SFP1_MOD_ABS_LS | TXGBE_SFP1_RX_LOS_LS))
>  		return status;
>=20
> -	for (i =3D 0; i < 4; i++) {
> -		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
> -		if (link_up)
> -			break;
> -		msleep(250);
> -	}

txgbe_e56_check_phy_link() is deleted here, but still be invoked in
txgbe_setup_mac_link_multispeed_fiber_aml() ?

> +	status =3D hw->mac.check_link(hw, &link_speed, &link_up,
> +				    autoneg_wait_to_complete);
>=20
> -	if (link_speed =3D=3D speed && link_up &&
> -	   !(speed =3D=3D TXGBE_LINK_SPEED_25GB_FULL))
> +	if (link_speed =3D=3D speed && link_up)
>  		return status;
>=20
> -	rte_spinlock_lock(&hw->phy_lock);
> -	ret_status =3D 0;
> -	rte_spinlock_unlock(&hw->phy_lock);
> +	if (speed & TXGBE_LINK_SPEED_25GB_FULL)
> +		speed =3D 0x10;
> +	else if (speed & TXGBE_LINK_SPEED_10GB_FULL)
> +		speed =3D 0x08;
>=20
> -	if (ret_status =3D=3D TXGBE_ERR_PHY_INIT_NOT_DONE)
> -		return status;
> +	status =3D hw->phy.set_link_hostif(hw, (u8)speed, autoneg, true);
>=20
> -	for (i =3D 0; i < 4; i++) {
> -		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
> -		if (link_up)
> -			return status;
> -		msleep(250);
> -		}
> +	txgbe_wait_for_link_up_aml(hw, speed);
>=20
>  	return status;
>  }
> diff --git a/drivers/net/txgbe/base/txgbe_aml40.c =
b/drivers/net/txgbe/base/txgbe_aml40.c
> index 2bad990aa8..88408550d2 100644
> --- a/drivers/net/txgbe/base/txgbe_aml40.c
> +++ b/drivers/net/txgbe/base/txgbe_aml40.c
> @@ -106,7 +106,42 @@ s32 txgbe_setup_mac_link_aml40(struct txgbe_hw =
*hw,
>  			       u32 speed,
>  			       bool autoneg_wait_to_complete)
>  {
> -	return 0;
> +	bool autoneg =3D false;
> +	s32 status =3D 0;
> +	u32 link_speed =3D TXGBE_LINK_SPEED_UNKNOWN;
> +	bool link_up =3D false;
> +	u32 link_capabilities =3D TXGBE_LINK_SPEED_UNKNOWN;
> +	u32 value =3D 0;
> +
> +	if (hw->phy.sfp_type =3D=3D txgbe_sfp_type_not_present) {
> +		DEBUGOUT("SFP not detected, skip setup mac link");
> +		return 0;
> +	}
> +
> +	/* Check to see if speed passed in is supported. */
> +	status =3D hw->mac.get_link_capabilities(hw,
> +			&link_capabilities, &autoneg);
> +	if (status)
> +		return status;
> +
> +	speed &=3D link_capabilities;
> +	if (speed =3D=3D TXGBE_LINK_SPEED_UNKNOWN)
> +		return TXGBE_ERR_LINK_SETUP;
> +
> +	status =3D hw->mac.check_link(hw, &link_speed, &link_up,
> +				    autoneg_wait_to_complete);
> +
> +	if (link_speed =3D=3D speed && link_up)
> +		return status;
> +
> +	if (speed & TXGBE_LINK_SPEED_40GB_FULL)
> +		speed =3D 0x20;
> +
> +	status =3D hw->phy.set_link_hostif(hw, (u8)speed, autoneg, true);
> +
> +	txgbe_wait_for_link_up_aml(hw, speed);
> +
> +	return status;
>  }

The commit log does not explain why aml40 should be configured in this =
patch.
=20

