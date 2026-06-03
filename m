Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA60CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 21:43:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D2A2402F1;
	Wed,  3 Jun 2026 23:43:12 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 2D8E4402BA
 for <dev@dpdk.org>; Wed,  3 Jun 2026 23:43:11 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-137335bc3caso40604c88.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 14:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780522990;
 x=1781127790; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+P3AnSuFrTr/B/PJp+4ejOEb4D9Zy5euj185OPqglw=;
 b=HJpNPip8nKfeFYyeKqoJM+K8WssAljyuLDvbQNfrlaEJ8+5Z1Fwy9/hVobP2VoH2oL
 p3iZegX+0SgSP7x+DIhe/yKmZs6ZKZFwYr9aTTAdu4cAmWcO7+R1RUzw/zTXNvgsgHB3
 uWh4xaQDLI0VYWlUDXGMdN2vgld364C7o4NICSHGC9dG82JfQ51W632T/DhAj922Ivx8
 f7hfuO36+h4owdyVULSIh9LHHbAUuYAXpLsAxrTebGeoU6BRenhWWMCYPNVc5Q5zggCh
 l7kqMH72uTnhs8DXx2diHfI52UsYcYmvWb5a7BSr4oyyF6tFy3q/dGKMUkIYJQFUlsN0
 0RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780522990; x=1781127790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o+P3AnSuFrTr/B/PJp+4ejOEb4D9Zy5euj185OPqglw=;
 b=ObGNZxRn/qLUW/fa3XV1CsGer39fZ6CZQWNspfFYk7ERQxaihvWflsrgx6JwABCA6c
 x5N7YarSZNBahoghKtS+nGrjeOGJnc7nxn8oQfKy8DjQvZa3LYkml1MabqnU4uoJd9Qs
 H3V+TNnYTfJRBOaoomh3yL7WcIRd75EazgL8g9gKTc6yHPMYSLa14/WwgO0NLrmrRN8E
 nyp8+ZVgbh8pcvZAYNKNh4JzClNsv9lpVF7E8d6pToqlLMkKR4+LVWuM+DfnsXAUt4wA
 YL0S+Ksm/VTuIYrT6LH2Imzkt5G0deYs6g1lpMEVm97Z0aH2MIVJ2KuElqNWhSTkmgom
 M01Q==
X-Gm-Message-State: AOJu0YzlQPsWs3ySbtyTRWXgujbE1P2+nJkUyrKn2As/WDFLivEGxhlQ
 sDrQT1TAO6ItnsUn70h4WjQS9xFezDXtQJ8YbIJowdmy0G8T2p7YRL9p1CrZx7Hj4Ec=
X-Gm-Gg: Acq92OFu6GXt1w8GTTGs9QaaMcA30Coc5wN1/nfQsw86Y1034FrMslVq6PJcGwIDIsS
 CupKr97TVzUybrwNnKcrX6mIby/b3lqw3UXB6arbCSzQLy/M0/90wwRvkFFzPL0V7Wes7u/NPvT
 TIHxlWiyacPEu0ZOD3sp9AMcQ3uI2U/YgGcklaAcRpax9YqYHYJ1E/9K+NkP1pbEcghOPBFaHM/
 sYV088NSdxuiCyCV260G+Op9Rus4c+kHsdvgL2PN0O+dJml5VgFgzsxeplWizpjbLkyWhL3B/Ni
 JMVYl0d65U9Qadt+C26Is3Ua4uV6QNAteL6AlA8vIo4QqCDpgQo3Xvzlx9O16WPSn+HNcCMQ/mF
 8olaY7Eet/vJSbT83dJ3HyuE0MITjec8mQhdpmmvFR/cE+4eujHxl8Zf3uEMVa1uJqbHy86JDbw
 SgLlXv3Wlswz5oeSyd8hUB93i2AbEaUZ6SV/SIPqpulxUW2NyBjfds84rV1/R6jWGLgkSGUKfaK
 CY=
X-Received: by 2002:a05:7300:3210:b0:304:6448:dfd7 with SMTP id
 5a478bee46e88-3074fbc7800mr2596274eec.18.1780522990030; 
 Wed, 03 Jun 2026 14:43:10 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dcbe995sm4382585eec.13.2026.06.03.14.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 14:43:09 -0700 (PDT)
Date: Wed, 3 Jun 2026 14:43:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com, stable@dpdk.org, Ajit
 Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH 2/5] net/bnxt: use buf address for external mbuf
Message-ID: <20260603144307.0b9346a3@phoenix.local>
In-Reply-To: <20260603211341.2112344-3-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260603211341.2112344-3-Mohammad-Shuab.Siddique@broadcom.com>
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

On Wed,  3 Jun 2026 15:13:38 -0600
Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com> wrote:

> +static inline uint64_t
> +bnxt_mbuf_buf_addr(const struct rte_mbuf *mb)
> +{
> +	return (uint64_t)mb->buf_addr + mb->data_off;
> +}

Why are you reinventing this?

/**
 * A macro that points to an offset into the data in the mbuf.
 *
 * The returned pointer is cast to type t. Before using this
 * function, the user must ensure that the first segment is large
 * enough to accommodate its data.
 *
 * @param m
 *   The packet mbuf.
 * @param o
 *   The offset into the mbuf data.
 * @param t
 *   The type to cast the result into.
 */
#define rte_pktmbuf_mtod_offset(m, t, o)	\
	((t)(void *)((char *)(m)->buf_addr + (m)->data_off + (o)))
