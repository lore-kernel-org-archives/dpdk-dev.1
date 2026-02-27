Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B981F104891D
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 23:25:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B95104025F;
	Sat, 28 Feb 2026 00:25:35 +0100 (CET)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by mails.dpdk.org (Postfix) with ESMTP id 8B3ED4013F
 for <dev@dpdk.org>; Sat, 28 Feb 2026 00:25:34 +0100 (CET)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-12776bebe9fso1550986c88.1
 for <dev@dpdk.org>; Fri, 27 Feb 2026 15:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772234733;
 x=1772839533; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RXhyFLr22lJbLCCDRB/NPNNv13zll4NjzZ/eBJLCyrI=;
 b=ijNW8K/tLJHdn+o2m9/0s+jioPznO3Tgw6vLvZFUw3DlvtaJndx697v/Utl2z/awdu
 v2Zb18onFCno+D9mf70v4SFFn8EcXiOqdVdXcPygu3mUTv7DEwd+afKQF6UC2gCGgag5
 lvdP2xeNuDa+pUMZigoMoHbmC1mds2YP0A3dCCaasRrzEMyVUghsYMxzqj3XAmh2Dq7x
 uRztJdZcI1JY/MGPZ7lCle/cCnT0fBTTNA/LBym52LTZnYOMHxsmRNaV7irYcqZpviYY
 iqq0PH7uYSDRdFlHgkWe6xLYrVWzG7Nq3MRGHKpW7fKq3yeX2dB9rXCqe5pF/8o51Y0I
 so8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772234733; x=1772839533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RXhyFLr22lJbLCCDRB/NPNNv13zll4NjzZ/eBJLCyrI=;
 b=pYvxfe7QqW9cXT29299DiC2/xQhM61IE7HSc5ny2+u0iQ3aGG7A7kzoeH8KcUtvQb2
 3mriaAUgxLmY03gwe7ROpMz0Q6aNQ4WpzlrkJJC54McEgYFs407aLeKG87qsmSctvR4p
 /NxceDS2wZL4iorSyMKc7tdZ6jvWGMUsh9838f9uCkDoKi3rHDmGhBDNAOsZ6BVdTQ0T
 ynm5uYZ1Yo0UJLOFzNDf2YqqqkHLBjdEUgJw0HsALbSnzn/FpI1O2zoNGHllZMTWz3s5
 GO/PgjIVFfm529mcYpvLYDC6piism6g6XkTsAGhRPJjLfS2ix98p9sTOCw0bzMQ12WdT
 5y6w==
X-Gm-Message-State: AOJu0Ywm2atOklZwocJspfR1XlsIRQphuq3edXM3L5bD1detrTrnpytg
 JKifQG/OC0TrEUda6SlA22QYHogPV++l1cWNJklQp+0j4y8Ga6mkOAfpWxDV/tAghd9WcEs9xBL
 +rMqH
X-Gm-Gg: ATEYQzwl091Bvn8ZyJL3fQs5ib52Vpohg8EzraHeMdB0UxQyL77krVRsF24wDJ0P0zL
 hwE+nxRX/XVIHEPax0NBz5CS+3TgXex3vMzCmMkmPEyYeKsmWxIL1ghwRMOk46OIIfUp0g9KLg6
 MLdahp1T6RtKUh1deR/+psX+5DOwzcnp8RmcEdDl6Iq90t0cUNVBsJ//yCssauN0uJCvDFc39gD
 DoCrl7lnPJ8MKV3c3OSLoUbsxeKXUmIpQLRX4IrqZFaB/TUzIqnrDJ1y8E2Uvn9I39Fre2wjjKt
 1xJyCFsI9JU13mwOYwggDJqspguJnfIHwABbACRTPpLveLtUEizB+2wTUrpmljhmwKTNVe2cEYj
 0vGSVDF9oKaKTtFvdL/ZpYh+dtqSx+OYLXqDxy2i5MGXMCAxzc0sE4A4DLikuYZYo/EqT4AYa+o
 bb7SUtUvHpqS/sYQAH+C1g4kw8mF7zChZEQUO6BRg1V6ySyDZhYTRPW2wBJXANVE/81q42QUdic
 jI=
X-Received: by 2002:a05:7022:486:b0:11b:f056:a19b with SMTP id
 a92af1059eb24-1278fc645abmr2379193c88.18.1772234733398; 
 Fri, 27 Feb 2026 15:25:33 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1f68de3sm4731700eec.29.2026.02.27.15.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 15:25:33 -0800 (PST)
Date: Fri, 27 Feb 2026 15:25:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
Cc: <dev@dpdk.org>, <Selwin.Sebastian@amd.com>
Subject: Re: [PATCH v4 2/3] net/axgbe: add support for marvell m88e1512 PHY
Message-ID: <20260227152530.55efde7f@phoenix.local>
In-Reply-To: <20260227084431.709-1-ashokkumar.natarajan@amd.com>
References: <20260226164740.1401-1-ashokkumar.natarajan@amd.com>
 <20260227084431.709-1-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 27 Feb 2026 14:14:29 +0530
Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com> wrote:

> @@ -2556,6 +2922,21 @@ static int axgbe_phy_init(struct axgbe_port *pdata)
>  	}
> =20
>  	phy_data->phy_cdr_delay =3D AXGBE_CDR_DELAY_INIT;
> +
> +	ret =3D axgbe_get_phy_id(pdata);
> +	if (ret) {
> +		PMD_DRV_LOG_LINE(ERR, "failed to get PHY id");
> +		return ret;
> +	}
> +
> +	PMD_DRV_LOG_LINE(DEBUG, "PHY ID =3D 0x%x", phy_data->phy_id);
> +
> +	if (phy_data->phy_id =3D=3D M88E1512_E_PHY_ID) {
> +		ret =3D axgbe_m88e1512_init(pdata);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }

AI was confused and thinks that there may be an issue here:


Patch 2/3: net/axgbe: add support for marvell m88e1512 PHY
Error =E2=80=94 axgbe_get_phy_id() called unconditionally in axgbe_phy_init=
() (potential regression)
This is the most significant finding in the series. axgbe_get_phy_id() is i=
nserted at the end of axgbe_phy_init() without any guard on port mode:

=EF=BF=BC
c
 	phy_data->phy_cdr_delay =3D AXGBE_CDR_DELAY_INIT;
+
+	ret =3D axgbe_get_phy_id(pdata);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "failed to get PHY id");
+		return ret;
+	}
axgbe_phy_init() is called for all port modes =E2=80=94 SFP, backplane, 10G=
BASE-T, etc. For port modes that have no external PHY, axgbe_phy_read() wil=
l attempt a Clause 22 MDIO read on phy_data->mdio_addr and likely timeout (=
-ETIMEDOUT), causing the entire PHY init to fail. This is a regression for =
devices that previously worked.

The M88E1512-specific init block below already checks phy_data->phy_id, but=
 the axgbe_get_phy_id() call itself must not fail for non-1000BASE-T ports.

Fix: Gate the PHY ID read (and subsequent M88E1512 init) on the port mode:

=EF=BF=BC
c
	if (phy_data->port_mode =3D=3D AXGBE_PORT_MODE_1000BASE_T) {
		ret =3D axgbe_get_phy_id(pdata);
		if (ret) {
			PMD_DRV_LOG_LINE(ERR, "failed to get PHY id");
			return ret;
		}

		if (phy_data->phy_id =3D=3D M88E1512_E_PHY_ID) {
			ret =3D axgbe_m88e1512_init(pdata);
			if (ret)
				return ret;
		}
	}
This is consistent with how axgbe_phy_link_status() in the same patch corre=
ctly guards the external PHY check with if (phy_data->port_mode =3D=3D AXGB=
E_PORT_MODE_1000BASE_T).

Confidence: High (~90%). The MDIO read will go through hardware I/O regardl=
ess of whether a PHY exists at the address.
