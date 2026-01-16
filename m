Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC54AC982E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 17:36:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08C5042E70;
	Fri, 16 Jan 2026 18:36:10 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 0FBBA4026A
 for <dev@dpdk.org>; Fri, 16 Jan 2026 18:36:08 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so21914055e9.2
 for <dev@dpdk.org>; Fri, 16 Jan 2026 09:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768584968;
 x=1769189768; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Bim/EA7TLHu8NYO2hfyoyJsWCGeyUyAH3S9c7lgfsE=;
 b=T38hsrpns7o3lcOYHHtn8DLM03AgVDJZS8B1ly6zCbh+Wr4WKkARuDo4E0SUwlxIr4
 vmwzpiBfJHkB5R4Ci1pJtx6NscDs18ej+rR0A/bnvruD8Ja/M9FiHVFa7GTFx3dJfhVn
 Uybr4tSCqAmuXXeurkFSGdWpjsOYer+0pjthyOnOdqYvPQxhWnvzCKgwxyaxW+2WiRw7
 rzFUqLr2bIeD1B/Up3QfCdoThMA0MB9cU0Ez4nUDl7w2LS8l0/QxGAJlScq9UrK0IvTk
 P5U8rKrBZqJw4C0ftbrEeKFbzBv417IH2B25NeUYVbnk0OWoD2pdvVi6X9HEQo37Eo8m
 /kyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768584968; x=1769189768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Bim/EA7TLHu8NYO2hfyoyJsWCGeyUyAH3S9c7lgfsE=;
 b=ORjeMxJh3xFfjKivFL7fBE6JR4DIBId6lIpiFgWEvoU6U8KrsyBxpM8+L+dAHr74hA
 332Tl0vFEwf2cyi9D6G+BStS3Q4jxiVoaxT6iSpMFXwDLSs4+7t8fnrYhNZ7ZeBd7VTg
 tHYazZvXrJ35l5QMLH/8VFs2I8ns9lbrKzYxdr515D/H+ivfL4++pVFWVkBBVTw1/n58
 ifzNDf5oZSAEBTbDQTfHyktqDYGLxqTiltMmpWB+dyAmxmbZ/k3T1xn9Jn+uJDKi+/27
 Ng8at6mlO1xC3nYsKy2jTAuUv01yxRasIEAJkaW9aq+JS8No8/csfnvbFyzgeYY7bKHR
 zqfw==
X-Gm-Message-State: AOJu0Yw9gOrnsE2kGm7Vj2qMXcILaKOr+3hlW+sy2CKKO8sMKX//snY2
 CdDPV8MJdeWL/Bw6PlvueIiUn7ibKr2qKU83Rpm2YyU0ZWlYfwktWJ7kcRO6+wh6Tv5YurBkShu
 Z7pXH
X-Gm-Gg: AY/fxX4qmkHDyq1MrtDhdgME2nO/UkTk242VLxu/7L4mV/2b88FXnJRvsR/OiqTFXEs
 Hnlw63Gj/oTfYF5g/bLpcQmh++UjKItuxzADwVelsATFbfrbS7nOBllPPV45DjT2GHv4fVXE8WP
 WpGAmuHsKjXhGO08duweo7/p7GPMODzQocIMGM1vnCXpAVq+ASFM7qaayaNkCggHBiISSkkONl7
 /lNNvai0WFDjubii6UkL6Fc+Ho9rBavOb+sKsz3x5vYfs9EenRbxmjClvNPZcyemqtbTVgcRnyY
 aSlxH5PzYmL4W8qeXAZ3Sc8l5myU+8Wfh8DEGRMkfqo1s4ZVqBlEmiuzpaUCr7WKXcmMfgxNioH
 wPw90nvtcESh+w422K8BeYMARSmd+M1u9o1DqIx3c5p/YSCvmsDLHW4X7kY0YQvEfwN7+Pgz+ZD
 mwJ3ZWtlODqxSPPi3eBLXPn0cH/y3fAkOuV34FKd87+jE5776vG+BH
X-Received: by 2002:a05:600c:4f8a:b0:480:1d32:afc6 with SMTP id
 5b1f17b1804b1-4801e2f8e54mr47697755e9.4.1768584967603; 
 Fri, 16 Jan 2026 09:36:07 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569926648sm6696513f8f.10.2026.01.16.09.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:36:07 -0800 (PST)
Date: Fri, 16 Jan 2026 09:36:02 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH 4/8] net/nfb: add device argument "port" to limit used
 ports
Message-ID: <20260116093602.3fad3610@phoenix.local>
In-Reply-To: <20260115151656.393106-5-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260115151656.393106-5-spinler@cesnet.cz>
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

On Thu, 15 Jan 2026 16:16:52 +0100
spinler@cesnet.cz wrote:

>  
> +static int fill_port_mask(const char *key __rte_unused, const char *value, void *opaque)
> +{
> +	int ret = 0;
> +	char *end = NULL;
> +	uint64_t *port_mask = opaque;
> +	int port;
> +
> +	port = strtol(value, &end, 16);
> +	if ((value[0] == '\0') || (end == NULL) || (*end != '\0'))
> +		ret = -1;
> +
> +	if (ret != 0 || port >= 64 || port < 0)
> +		return -1;
> +
> +	*port_mask |= (1ull << port);
> +	return 0;
> +}

Do you really want to allow negative values, why not use strtoul()
Also, if there is a limit of 64 this should be a #define or config constant
