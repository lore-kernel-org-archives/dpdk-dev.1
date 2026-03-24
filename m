Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78AFF54AD0
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:01:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB592402BE;
	Tue, 24 Mar 2026 17:01:01 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id AE5AE4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:00:59 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-35bb7afdc38so779668a91.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774368059;
 x=1774972859; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7S1usnmNUDa34fXxSJ/RkWMdReoE+1EEFharEWCaNp0=;
 b=zDUj6DF0/SspNuyzp98Dqx6aD9gLdbZn3swVv5yeuyTe+INityyWBpA8lxXsCmTyda
 ZUMVh33OCkqfJuRkNS96wjpCnHLnK3RRfoDvi21rhu/eUI7BoVFnRTRnjpae2pcA1wU/
 Ol0rnyp8CNi8IZdTiOhgYKDDHFpvnl1ITwhF2VYPTp8fo9CmAGlqLt334Zqh4YntVPDn
 yJMoRfZd6eQ9GaOY/dzo38g5YTT7dN0ny+nfLBfJmVXU+IGyaWcddKzCUa8EdJxk8SLn
 W7vcn6aw+lGsP/n8H3KItbHtMiN+WgbYzF9uuEAzSAhuXWaValydqJAG30DCR3fC0dZO
 jCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774368059; x=1774972859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7S1usnmNUDa34fXxSJ/RkWMdReoE+1EEFharEWCaNp0=;
 b=c9A1GntUfA+y+Xn2mOrbEXyCl64RXcDkbENekILXRN7quLmmiGcLrYfQWFuq1fA3Yg
 eG0zmwnamnQqUpvsvqtYa81eChGbcQhS7rsR/ql3Mzzj+xl48EouBaQCBJ2Jb7hjQbp0
 xQIqtKWt/4i8Qp8iXTDSgrlCPKeUzAVKNtr/+L4QRetl9nQ8n3qn6+LClWXaVndn+op8
 4dM8xr9xuttIfGeRjdjqgWp+GxG9Y7A9pYmfmIwWPQqctRoJW4DBhRWgUmE+BFTiwAM3
 RBQ46IG3PtRB8lLDp8GFfR9zbIcwnrdhlovd+xBuCxVapoSm669NgucyL6LqtmUh/dnT
 YUJw==
X-Gm-Message-State: AOJu0YyTWhi8y1TmIudB13HFJFV8NW+0W2gJaB7FxIJShqNTLBHc+w4O
 V4ugZD7qscqzpLE6AMktoxo/tbhU4kfH0vBryMgSErgwlqRmcsg/AmQ35f+RRTR5s9o=
X-Gm-Gg: ATEYQzxVS1uQ3dZNHtW83Zt9d0hPKMXFflEDGKi1x9Qz7xemY071OSJxS/9m/nZBZJH
 eX75J+XTtYyrCvgb01NEOJjWIwfsHGW42Vq8xGraXPG6Umpfv9GuG4+EwvwxTY1YO9BwLOzctPf
 +MWXucNADBlJUTr4HZt1SdPNpLURD9mf3H4dB9gAY0HD34kiCENQLkChmNyfqPgZlpftv9hBGoe
 xATfhjOF2/GyT7eyzxRuQsipwauUrcSJP7vpxscJ8M6PBqYJdQWVkfnAe9ekEzDO29m9w3GMDvO
 n9vti3WLJu74kOMHhM3ZxYLHLZ19+vHBG5hfCU72SrKBnwUcxQLZzB1KjpY15kXi21cB7Wr0ml7
 /KBmV7N6zYO6FH6QnRnFnt3+t5msOEp3I6c3cCJK+he3V96wtgoGfrJPhz3XIafhkUJBM2ioT6/
 HDXL1xLOT5cqQWjKTPzY5noZQgzcKR55UZIRVzmJqhkC9i5w==
X-Received: by 2002:a17:90b:278e:b0:35b:cd3e:c4ab with SMTP id
 98e67ed59e1d1-35bd2c08ea2mr12986279a91.14.1774368058106; 
 Tue, 24 Mar 2026 09:00:58 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c0313eedasm2800461a91.5.2026.03.24.09.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 09:00:57 -0700 (PDT)
Date: Tue, 24 Mar 2026 09:00:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, stable@dpdk.org
Subject: Re: [PATCH v2] net/netvsc: switch data path to synthetic on device
 stop
Message-ID: <20260324090048.1db4dcfc@phoenix.local>
In-Reply-To: <20260323234957.1780150-1-longli@microsoft.com>
References: <20260323234957.1780150-1-longli@microsoft.com>
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

On Mon, 23 Mar 2026 16:49:57 -0700
Long Li <longli@microsoft.com> wrote:

> When DPDK stops a netvsc device (e.g. on testpmd quit), the data path
> was left pointing to the VF/MANA device. If the kernel netvsc driver
> subsequently reloads the MANA device and opens it, incoming traffic
> arrives on the MANA device immediately, before the queues are fully
> initialized. This causes bogus RX completion events to appear on the
> TX completion queue, triggering a kernel WARNING in mana_poll_tx_cq().
>=20
> Fix this by switching the data path back to synthetic (via
> NVS_DATAPATH_SYNTHETIC) in hn_vf_stop() before stopping the VF device.
> This tells the host to route traffic through the synthetic path, so
> that when the MANA driver recreates its queues, no unexpected traffic
> arrives until netvsc explicitly switches back to VF.
>=20
> Also update hn_vf_start() to switch the data path back to VF after the
> VF device is started, enabling correct stop/start cycling.
>=20
> Both functions now use write locks instead of read locks since they
> modify vf_vsc_switched state.
>=20
> Fixes: dc7680e8597c ("net/netvsc: support integrated VF")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---

AI spotted that ret is overwritten on error path


**Patch: [PATCH v2] net/netvsc: switch data path to synthetic on device sto=
p**

The v2 addresses the two issues from v1 review: `hn_vf_stop()` now only cle=
ars `vf_vsc_switched` on success, and `hn_vf_start()` now stops the VF if t=
he datapath switch fails. Both fixes are correct.

**Warning: `hn_vf_stop()` =E2=80=94 `ret` from failed datapath switch is ov=
erwritten by `rte_eth_dev_stop()`**

When `hn_nvs_set_datapath(hv, NVS_DATAPATH_SYNTHETIC)` fails, `ret` holds t=
hat error. But execution falls through to `rte_eth_dev_stop()`, which overw=
rites `ret`. The caller loses the datapath switch failure =E2=80=94 if `rte=
_eth_dev_stop()` succeeds, `hn_vf_stop()` returns 0 despite the datapath sw=
itch having failed. If the intent is to always stop the VF regardless of th=
e switch result (reasonable), the datapath error should be preserved separa=
tely, or the function should return the first error. Something like:

```c
		if (hv->vf_ctx.vf_vsc_switched) {
			ret =3D hn_nvs_set_datapath(hv, NVS_DATAPATH_SYNTHETIC);
			if (ret) {
				PMD_DRV_LOG(ERR,
					    "Failed to switch to synthetic: %d",
					    ret);
			} else {
				hv->vf_ctx.vf_vsc_switched =3D false;
			}
		}

		err =3D rte_eth_dev_stop(vf_dev->data->port_id);
		if (err !=3D 0)
			PMD_DRV_LOG(ERR, "Failed to stop device on port %u",
				    vf_dev->data->port_id);
		if (ret =3D=3D 0)
			ret =3D err;
```

This preserves the first error while still attempting to stop the VF.

Everything else looks correct. The lock upgrades from read to write are app=
ropriate, the conditional logic in `hn_vf_add_unlocked()` correctly defers =
the datapath switch when the device isn't started, and `hn_vf_start()` prop=
erly rolls back the VF start on datapath switch failure.

