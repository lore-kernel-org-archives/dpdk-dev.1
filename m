Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D241CD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 18:32:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB1EE40B97;
	Mon, 15 Jun 2026 20:32:33 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id 7C859400D6
 for <dev@dpdk.org>; Mon, 15 Jun 2026 20:32:32 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-137eb0d76beso3126694c88.0
 for <dev@dpdk.org>; Mon, 15 Jun 2026 11:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781548351;
 x=1782153151; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4h+3QsBNUKDVuGqIn4XVIWbB3e0jB4R9PCegDemJD+w=;
 b=tW4x9W7UpY8xaDvjFKyOW2xebGv/DaBdbc0iY9uXwBbV86F+JOMBoeN/V5TREFdSix
 mv8wLfqas/G0EleJDT50D+XxlzF4PbQjlCYlWdamV7CD49eW6+M6p7dzOhm8iw1VkDt9
 NfaOfV8qd1nuS7PfpmkLnVLgskT0EqJXdcOMc1vRqnWGtTpW/Maym1HPXG4biaKSxkDH
 SjAmJO6gldFiWLjzfFx5NTvfQqgzxBWlWYimUQxUb6xMKnkd5nw7Uyf2y52fQz49oRmo
 UPAK6ZIexni0jCr24xJFlzPIqxc/b8z5oRfT8BVF3UxGWRYyKCTPo4n18kNJUc8gZJow
 FXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781548351; x=1782153151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4h+3QsBNUKDVuGqIn4XVIWbB3e0jB4R9PCegDemJD+w=;
 b=ij2FKPVTp1lKa/N9nZ1KFZ8m9uFVwYQgSIbjuJj3t3SMElahJ/Q22MNTdx6iHTyFAJ
 n6hrqQ0krc/p3ad9o6QsjLhNKp21zbli8hmy2N+XGv0ecNr4YjVzBCTdQwo5TnwCfmKw
 lLWTBC1o5Zmod8dfpyPjdotLz5tmRCOai/ta5MOh0DcELJo7aXf5HI9TQSaRJoCocAv/
 cOcb/jcudMvBbOLP1xdwvMSdxDacMt+7gw0J+yiYhRTbrE9pF3W0J4ZGnK3I/IRSB1Bx
 Gzvwf8VPRZCJrBWSyKxLvD2hw3pjTAb99lui0QLa7m2h9xk0bYH4jOpu1djpqdmrIfHu
 HZDw==
X-Gm-Message-State: AOJu0Yxaa9AuuR+5jyxo3/a0onKs8PtFJuVu2d+d28tIOy1PUqwAZLer
 TLsORSqwuSGUbbQ8qarmArIWaJ7ClyNyxho925dkgTIkqgH6gPTcaXDNzfYqSblTlDgQHClD0It
 qqPl3
X-Gm-Gg: Acq92OFP4fBaT2OJU5DQ+CbfOtd+utxZpZE6t7Zes/18c72JEmQnee6rGn913zbGy1v
 NkVhVUdEisldWe1ruaHSlWS5taMz1Kydpl38zrr+3j0924Zkss85Izb1I1twYMJCpAsR6HZbQ4p
 aviqaf2y4dvENJMDM+RHbovJRnGULp4CQkBVAjZJVG2rbjZjlwLJ626eZ8ehizwcmOThXQsDDAg
 5XGSZS9z8mJkggI64irtMdtd2+PEDIacsyBZbGAIhOgJM2LmpAuC3CrsMd5kKBf7to8fTT/ofuk
 sQPkQb36Iemln6niie4w6S1ZcLlsMzZZW8d9dxZaxRXutWNPEpZuVMf7GiDWBJgv4Pq8zDEyWw6
 lbFZaGrU0YNcnuDL5rHekD0eEtCzQgqbrLSqEsXKL15VzudgjCWj/ijGeoAjZUYdYNeQErvJFMV
 9X8yI0il/LHvME9AOVL7pQ8cjn4vP6TgrN0d3dPry/9QI1n/Y6FsxR7mhp74HnYeWw
X-Received: by 2002:a05:701b:220e:b0:133:39b9:9720 with SMTP id
 a92af1059eb24-139857f572fmr199904c88.16.1781548351286; 
 Mon, 15 Jun 2026 11:32:31 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97570asm10612099c88.12.2026.06.15.11.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:32:30 -0700 (PDT)
Date: Mon, 15 Jun 2026 11:32:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 03/20] drivers: add supported packet types get callback
Message-ID: <20260615113228.65b2e278@phoenix.local>
In-Reply-To: <20260614092328.201826-6-liujie5@linkdatatechnology.com>
References: <20260610013936.3634968-21-liujie5@linkdatatechnology.com>
 <20260614092328.201826-1-liujie5@linkdatatechnology.com>
 <20260614092328.201826-6-liujie5@linkdatatechnology.com>
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

On Sun, 14 Jun 2026 17:23:07 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> Implement dev_supported_ptypes_get ethdev callback for sxe2 PMD.
> This allows applications to query the packet types the driver
> is capable of identifying, such as L2, L3 (IPv4/IPv6), and
> L4 (TCP/UDP/SCTP) layers.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

This patch has lots of other changes like link state.

> +static inline const uint32_t *
> +sxe2_dev_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
> +{
> +	const uint32_t *ret = NULL;
> +
> +	static const uint32_t ptypes[] = {
> +		RTE_PTYPE_L2_ETHER,
> +		RTE_PTYPE_L2_ETHER_TIMESYNC,
> +		RTE_PTYPE_L2_ETHER_LLDP,
> +		RTE_PTYPE_L2_ETHER_ARP,
> +		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN,
Why an inline for something in control path which then has to be a function
since it used as ethdev op.

> static inline void sxe2_init_ptype_list(uint32_t *ptype)
> +{
> +	/* ptype[0] reserved */
> +	ptype[1] = RTE_PTYPE_L2_ETHER;
> +	ptype[2] = RTE_PTYPE_L2_ETHER_TIMESYNC;
> +	/* ptype[3] - ptype[5] reserved */
> +	ptype[6] = RTE_PTYPE_L2_ETHER_LLDP;
> +	/* ECP */
> +	ptype[7] = RTE_PTYPE_UNKNOWN;
> +	/* ptype[8] - ptype[9] reserved */
> +	/* EAPol */
> +	ptype[10] = RTE_PTYPE_UNKNOWN;
> +	ptype[11] = RTE_PTYPE_L2_ETHER_ARP;
> +	/* ptype[12] - ptype[21] reserved */
> +

Why are you building the whole table at runtime? It could just be
one constant table setup at build time.

> +int32_t sxe2_mtu_set(struct rte_eth_dev *dev, uint16_t mtu __rte_unused)
> +{
> +	int32_t ret                      = -1;
> +	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
> +
> +	PMD_INIT_FUNC_TRACE();
> +
> +	if (dev->data->dev_started != 0) {
> +		PMD_DEV_LOG_ERR(adapter, DRV, "port %d must be stopped before configuration",
> +				dev->data->port_id);
> +		ret = -1;
> +		goto l_end;
Just return and skip the variable ret and goto.
A good return code would be -EBUSY.

> +	}
> +
> +	ret = 0;
> +
> +l_end:
> +	return ret;
> +}
