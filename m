Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26073C44506
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 20:58:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC9CF4279D;
	Wed, 21 Jan 2026 21:58:20 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 863E24027A
 for <dev@dpdk.org>; Wed, 21 Jan 2026 21:58:18 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so2065475e9.0
 for <dev@dpdk.org>; Wed, 21 Jan 2026 12:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769029098;
 x=1769633898; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y899+1eF6E3Z481XSUmqc3rAvF9c9pCeNLutGMHF6Ng=;
 b=Xm+Mmg0sD/9v+U5YZLJZrv/cWF6YhBxafGY/3G45N/lIcTVVNF08xpHJb0o914Jba2
 9rzM4tnY7c9Qk/RtkBUPJNf163mUjT+j421J1tohRX9nw2HYqtU52Fdg+uzvYB+Nncb3
 8YucZ+XcpeAbnwDlWMasmEouLu9In/ql07S/fz1jLg0/A9J7ugraA84Zxcsho7IZS5OC
 s9usdy3orNXX7wCzJ7yhkQxBwGxpBn1XtM+yxd5pfFkEmX/sarRkaiNeZRNSSDb7dImq
 kE1L11XmV4JfflTzOGJ8PZt/3CDvBWVMvmZu17MmEXAVuxQ7W7IWyOc4pSPs01i9mAJO
 vjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769029098; x=1769633898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y899+1eF6E3Z481XSUmqc3rAvF9c9pCeNLutGMHF6Ng=;
 b=Mey9BfgtvGNHGiPle2KOIu09aTL28nt8rA+nQmIGuY4jopFa4vftUFe8/ZG8a2UiUS
 nwcKAqsPdAStvp8Bwowvobhgh03cm9slefCCbTqW/JdL2RhhwpZ3MgQUFbcq1kUKy6ww
 NzqcZkNUg05xrzdPFMgszljlV4t8DRGLARyiuX4gtzMc4BoBjmUhPL5FB6TDnIxTLbQR
 Z92BRxVYJMxuGEiSzqgYcQRBO1I3GSp013DAgiesXQLQKm6MnGoWqsbTdMhHKVIFbi8l
 J/Kg7/aB2p0GHJxF8s1fGvO20O5C4VRY7iXpKEZipiE5GIGhdVjbiHhGLEsZ3VD6LT3O
 fagw==
X-Gm-Message-State: AOJu0YzijeXFkKfKAmfumAywjroVx76BN4plS5luUYCnkX7+/VWNSKz0
 j7pGAz5FwWC2XokMZNoUiMTSQVFBWlmtxdAzygo7AmcdkzewUx/x5xBBJ9ZDjY9s9zU=
X-Gm-Gg: AZuq6aJwJd2HBl6bMYV1pycI4hp4JOtBop4FAgAS8MPT+Gb9GOR+Eo2aOSgaR5TW2F1
 cWdmdxPxx5UC+IwBWTCYfStkfWdVsNBElbRmnKzQYR6xuaqvCm8CDK1YKF2PG8bLfq2kphJ5vj2
 r3OL5vgZTqp4umckpAJYM8ZZB6tQgwE6kFg4jUZZ3pROwnam9igadBSrS/zZotI+87MCEVFrARE
 EjkU8paZcmjz+3lbYO+2LpDl6TRnkiG1fYLh23mCUt0mQ5t5whEXHB3KypS4p4+AsYcWKupdZcb
 zV5LrJQQ02drLnzodNQ7Jamf8R3cbk0Os5FTLrzGFRTDVe8QT8sWAb7IFxfvev9ZF6AijKgPAUN
 6XMrdyfLQY+Fa/dJ/xicFn/YDMX/bKy7c5+eSw6yahkszJgLvOs3+wL3jNwcTEEEZFvzwb+UfNw
 f1VbdSbir+HigF7EiHd42UaXMCwSIbTAc2pOWdcC0XRSqwXMx6vXR4
X-Received: by 2002:a05:600c:1c18:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-4804820fe52mr7267875e9.14.1769029097887; 
 Wed, 21 Jan 2026 12:58:17 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470bfe42sm13666055e9.9.2026.01.21.12.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 12:58:17 -0800 (PST)
Date: Wed, 21 Jan 2026 12:58:12 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Jasper Tran O'Leary" <jtranoleary@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Subject: Re: [PATCH v2] net/gve: add reset path
Message-ID: <20260121125812.277dbacf@phoenix.local>
In-Reply-To: <20260121193018.2728602-1-jtranoleary@google.com>
References: <20260121193018.2728602-1-jtranoleary@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 21 Jan 2026 19:30:18 +0000
"Jasper Tran O'Leary" <jtranoleary@google.com> wrote:

> +static int
> +gve_dev_reset(struct rte_eth_dev *dev)
> +{
> +	struct gve_priv *priv = dev->data->dev_private;
> +	int err;
> +
> +	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
> +		PMD_DRV_LOG(ERR,
> +			"Device reset on port %u not supported in secondary processes.",
> +			dev->data->port_id);
> +		return -EPERM;
> +	}
> +
> +	if (dev->data->dev_started) {
> +		PMD_DRV_LOG(ERR,
> +			"Must stop device on port %u before reset.",
> +			dev->data->port_id);
> +		return -EBUSY;
> +	}

That check is not necessary, because rte_eth_dev_reset always does stop:

int
rte_eth_dev_reset(uint16_t port_id)
{
	struct rte_eth_dev *dev;
	int ret;

	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
	dev = &rte_eth_devices[port_id];

	if (dev->dev_ops->dev_reset == NULL)
		return -ENOTSUP;

	ret = rte_eth_dev_stop(port_id);
	if (ret != 0) {
		RTE_ETHDEV_LOG_LINE(ERR,
			"Failed to stop device (port %u) before reset: %s - ignore",
			port_id, rte_strerror(-ret));
	}
	ret = eth_err(port_id, dev->dev_ops->dev_reset(dev));

	rte_ethdev_trace_reset(port_id, ret);

	return ret;
}

And therefore the documentation should be updated as well.
