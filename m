Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665E7E7FDC7
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 20:03:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 790564027D;
	Mon,  2 Feb 2026 21:03:22 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 37DD04026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 21:03:21 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so39403555e9.3
 for <dev@dpdk.org>; Mon, 02 Feb 2026 12:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770062601;
 x=1770667401; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PqfeaWf7fdJj8gUT/bcE1mbaj2uruCQGXMoTcbVxQiU=;
 b=LD0oocLm0DQ//A8uOGcj3d44RiRIBxShe/pNKPB15IcXoyOm7k0LLlOTL+kLMOBhKu
 3gwmS+bpVA6kQoCPv9G3a3zwEQf9aOiGE04KyUpMQa/JRWHepEv69CSmGx215WGdwO4t
 qdxh6Tb0BkLxWo6qiMn5/LysTILeIt0R5hpUsw3iB0hI+HYLXY9Z66bF0Ich4nSylE8s
 AlPiBFafjU/fuMxkXbY2BlhQJGm3HGDLKZ746AX/tWaOoMipqYHF9fBxswsxx7UL8ZSz
 9PE9Y5XMdSMMrrx9sD1nJl7d80R6pSc6Qemx+Adm9vZHca/8RqyM2SE2XuCYs4hn24O5
 4lDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770062601; x=1770667401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PqfeaWf7fdJj8gUT/bcE1mbaj2uruCQGXMoTcbVxQiU=;
 b=o3gVp0oWXAu9dwpDfFIJZwVrq5YMs7BmukeFxcVpVfHjm1O3Dqp6r8tCEgxHnxAekk
 EUF5g0SaF5KpgUxBEWj1Aa2zSE1mcZwWQIw8bYpoS1CkDE5qyYge083IVPHxhogWsjT2
 aUOw3uB0KiBuNAv2Y7fq77FyribQjJFSwpZXMELP1ihR66Vo5wpkg8mZYkgpp550TmDJ
 HiNjbYAX0CqqnIt5cC9ibhxSML8qijvKK2xAya+e07Uy/LBzzrSjiRsYslEfq5WpCV1i
 OVvcmaLCbsIGM2fZFxmNJ2UlbrlxfluIQ0kiaBTgTO2pFWdbYzAdS4aB2VW6qhzAa2+a
 Qczw==
X-Gm-Message-State: AOJu0Yyixk5nxmJSYIeZQA4p08ghU2dcEaSeFvo9Uo/RAY976eHQxV3T
 iHV3m8z4toCYPzpZ0Dbz6Lcrc+UyEhbRKfhT472ehtAdZzk9PCwXbWV2vHTzj7knz0OWz5GxixZ
 0X977
X-Gm-Gg: AZuq6aIZMAFQ5Re89rKHDNJuzE4ziPFJRZwy5mqvuB0/ZgPaG53uYE9HDa1t6Dsjiph
 Twgg8MgbvmoAb9wbzXhWBTVfwaiOmMKQWCz9UxmwagrGONLarhW+Xdkw4bUk6YnA8qYKq9n+mCX
 h7O9ucoieBjEjDuj+KpDekz/oacvoJm83R/l6FRABK+L8jvQM3O+6zW/UwcGp9SBGDx1nkay8sa
 hfacFwE7lxigC7ZLsdaeKWgmwIljW2/iBOTA2rUAWdrFoUevSRdtegc1Ag1QQGaUEUaTOeKxJMr
 mRt6M1Q/vwCMlaGxpzgmOA5oXGNg0elj8+jCDNb85iIzdTa38Rse82D8S7wSK0dynmmOWPhtXA2
 +YQDGzHCmpJ9rxeA4nCG9jWQTsTAYMfNt8LVbfwQDuVrazRT56aZJLB2UxpN4zf21Y0d1uCNbR4
 eBq0WNyZA4b4Cpy6tAAJ81lm9f4WVn1ev/SojpOBXkQm+daYsEkl9A
X-Received: by 2002:a05:600c:3b96:b0:480:1c10:5633 with SMTP id
 5b1f17b1804b1-482db49978emr162302365e9.26.1770062600462; 
 Mon, 02 Feb 2026 12:03:20 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48305129419sm10668435e9.6.2026.02.02.12.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 12:03:20 -0800 (PST)
Date: Mon, 2 Feb 2026 12:03:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 3/6] flow_parser: add shared parser library
Message-ID: <20260202120313.15ecedb3@phoenix.local>
In-Reply-To: <20260202113659.24052-4-sismis@dyna-nic.com>
References: <20260202113659.24052-1-sismis@dyna-nic.com>
 <20260202113659.24052-4-sismis@dyna-nic.com>
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

On Mon,  2 Feb 2026 12:36:55 +0100
Lukas Sismis <sismis@dyna-nic.com> wrote:

> +int
> +rte_flow_parser_run(const char *src)
> +{
> +	uint8_t buf[4096];
> +	struct rte_flow_parser_output *out = (struct rte_flow_parser_output *)buf;
> +	int ret;
> +
> +	ret = rte_flow_parser_parse(src,
> +				    (struct rte_flow_parser_output *)buf,
> +				    sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +	switch (out->command) {
> +	case RTE_FLOW_PARSER_CMD_SET_SAMPLE_ACTIONS:
> +	case RTE_FLOW_PARSER_CMD_SET_IPV6_EXT_PUSH:
> +	case RTE_FLOW_PARSER_CMD_SET_IPV6_EXT_REMOVE:
> +	case RTE_FLOW_PARSER_CMD_SET_RAW_ENCAP:
> +	case RTE_FLOW_PARSER_CMD_SET_RAW_DECAP:
> +		cmd_set_raw_parsed(out);
> +		break;
> +	default:
> +		return cmd_flow_parsed(out);
> +		break;

The kernel version of checkpatch complains here. The DPDK shell script
seems to be set to ignore this but. 

WARNING: break is not useful after a return
#15008: FILE: lib/flow_parser/rte_flow_parser.c:14763:
+		return cmd_flow_parsed(out);
+		break;

