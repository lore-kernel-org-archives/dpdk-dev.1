Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88678C83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 15:12:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4E2640685;
	Mon, 30 Jun 2025 17:12:31 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id 56EE340684
 for <dev@dpdk.org>; Mon, 30 Jun 2025 17:12:30 +0200 (CEST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-6fada2dd785so28422146d6.2
 for <dev@dpdk.org>; Mon, 30 Jun 2025 08:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751296350;
 x=1751901150; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1NgKvDS/Zs0q7VJKhGD53ExKE88r0vb3xK99RQ50LPk=;
 b=HbtTtr9RDEjQaFz4Tcn0NtGRhkxtTD94xJhfHv/CXXHRE0arTES9VDYnijR7sZ3QTV
 G+n1BEQMtDc3Enm/rbCumRMSwwSwtKvaGzZiqlHESyJsQwh1/k9w2mrEZ+aVfznbx4Cy
 oGmFTJ5KMArv2eIu4te63KEc6N8p0N8TZFNjkn33SyU3pidq535V/mHGLvSTgH061Zjx
 ZconuG/mdcw5zLQWp0cgKTZoXW/CQaihEC8z1sItUWrAImanTQ3LxFOMf7TermSEtVEl
 EWIT4MXqAGvzC57C/hUOE+Yk09EVAtOYrFGBqh+DTFB3EswgwLJZPAaqA89gmUk2ldMi
 cC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751296350; x=1751901150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1NgKvDS/Zs0q7VJKhGD53ExKE88r0vb3xK99RQ50LPk=;
 b=hnmKqVdkPcy6Z2MTTE4rZY9Qt+c82c40vs5lEBpUlkTkiQzT2zAwcUfzhhY1uLF7M7
 eKHWcMdlRhbZBRbmusAaM6fyJc38upe2NSTBeMnY7B/OSnjZ4tvKTjOWM7fKuxt7+5s6
 7Z36F/hjMhkTkqOIMDIT08o4+skKQ3TfAaAjd8dV1Rsg616C1IcRAy7bIHF25+bHGdfE
 UnmIdH9WQ9DHvaZpRLOkXubp8axvzt2kMXKvLPHK6zFRNaI5Mo/HZyVD7xaWMn3f6ibV
 NJmvRVSJiQht2Eaom6OQEytQHsLrwu4H8rDe4RBSGMvJ0eOnc78Nlh5IocXg65i4lIGI
 F0Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMdT3k18XnHm+KWyJK8QTfucuYMxi5JUdcKoN38x6uWvkpXFni0x+DgvdyUfRxScKlrgo=@dpdk.org
X-Gm-Message-State: AOJu0YyMexaclLXiOTfV7PRXsUoYvsdyEXCm8JKvQky4xoP1LMWCXhMJ
 RLtvW1Q8bpoQrRaMPAy68SN9grCUT7Aip/DBRF8/gJlY7Y57xhSBAV+y5ddjCGsrmlQ=
X-Gm-Gg: ASbGncvanCadZiYwXpAr5Sk7XvBagfFEYbymzaZGzzTzFSO9GC3xKO02o5sRuciRQk/
 lG1ganDqMq2RJOskCyl9HLS0DchUTJ7l39ujYj9L7CJITyNegClyyOM3YJ//pOLDZRmaeepSHhf
 tZdfHHGqN1qSRDRU0t1GEShu30U/TyGvF5sLUfzI66g83vVB7I/Ticj3ITCebcNQT5C/ow8munT
 T8tICkePwNMEJcZZA9D5iRJrunB8tDdt93nyD3SulznNvdGQpTEYiWx8HUjVvXNyqgsWYAlhW/A
 iOlXzBnfvF6Pe8IsJCZjvAcY6IdVq2qe7fBQEmYW2QhfKFtTOmcyuY8lH6EQ6K5LTYIT103f70a
 LWUQ4v506A+a7uXMF6jNhqw4+rdueVJ79SnpnFaM=
X-Google-Smtp-Source: AGHT+IFQzlAxuYziE83qDpH1i2X00tT4Ihv5lEKXadXMsgerhMjFp/IYHLxHlAxD8rMiCcyjnBvqog==
X-Received: by 2002:a05:6214:5a08:b0:6ed:19d1:212f with SMTP id
 6a1803df08f44-6ffed7a5801mr241834006d6.5.1751296349535; 
 Mon, 30 Jun 2025 08:12:29 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd772e349dsm68686926d6.68.2025.06.30.08.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:12:29 -0700 (PDT)
Date: Mon, 30 Jun 2025 08:07:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: Ferruh Yigit <ferruh.yigit@amd.com>, dev@dpdk.org, yaojun@mucse.com,
 stable@dpdk.org
Subject: Re: [PATCH v2 1/3] net/rnp: add check firmware respond info
Message-ID: <20250630080710.09047543@hermes.local>
In-Reply-To: <20250630055753.35445-2-caowenbo@mucse.com>
References: <20250630055753.35445-1-caowenbo@mucse.com>
 <20250630055753.35445-2-caowenbo@mucse.com>
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

On Mon, 30 Jun 2025 13:57:51 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> Add logic checks at critical points to detect potentially illegal
> firmware information, preventing subsequent logic exceptions.
> 
> Fixes: 52aae4ed4ffb ("net/rnp: add device capabilities")
> Fixes: 52dfb84e14be ("net/rnp: add device init and uninit")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>

>  int rnp_mbx_fw_get_capability(struct rnp_eth_port *port)
>  {
>  	struct rnp_phy_abilities_rep ability;
> @@ -252,17 +253,29 @@ int rnp_mbx_fw_get_capability(struct rnp_eth_port *port)
>  		hw->nic_mode = ability.nic_mode;
>  		/* get phy<->lane mapping info */
>  		lane_cnt = rte_popcount32(hw->lane_mask);
> +		if (lane_cnt > RNP_MAX_PORT_OF_PF) {
> +			RNP_PMD_LOG(ERR, "firmware invalid lane_mask");
> +			return -EINVAL;
> +		}
>  		temp_mask = hw->lane_mask;
> +		if (temp_mask == 0 || temp_mask > RNP_MAX_LANE_MASK) {
> +			RNP_PMD_LOG(ERR, "lane_mask is invalid 0x%.2x", temp_mask);
> +			return -EINVAL;
> +		}
>  		if (ability.e.ports_is_sgmii_valid)
>  			is_sgmii_bits = ability.e.lane_is_sgmii;
>  		for (idx = 0; idx < lane_cnt; idx++) {
>  			hw->phy_port_ids[idx] = port_ids[idx];
> +			if (temp_mask == 0) {
> +				RNP_PMD_LOG(ERR, "temp_mask is zero at idx=%d", idx);
> +				return -EINVAL;
> +			}
>  			lane_bit = ffs(temp_mask) - 1;
>  			lane_idx = port_ids[idx] % lane_cnt;
>  			hw->lane_of_port[lane_idx] = lane_bit;
>  			is_sgmii = lane_bit & is_sgmii_bits ? 1 : 0;
>  			hw->lane_is_sgmii[lane_idx] = is_sgmii;
> -			temp_mask &= ~RTE_BIT32(lane_bit);
> +			temp_mask &= ~(1ULL << lane_bit);

Rather than using ffs directly better to consistently use rte_bitops
which has rte_ffs32().  You can address it in a future version.

