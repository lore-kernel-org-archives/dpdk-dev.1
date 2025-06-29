Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE651C7EE30
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 18:00:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F6D4402D2;
	Sun, 29 Jun 2025 20:00:23 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 7C20140288
 for <dev@dpdk.org>; Sun, 29 Jun 2025 20:00:21 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7d20451c016so77100085a.1
 for <dev@dpdk.org>; Sun, 29 Jun 2025 11:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751220020;
 x=1751824820; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHeF7WlFhuhAfPA2ohYAhUc06q34oX8ItkPcCauHxZc=;
 b=ZUyNggaVB9MTIjR2BBKKbgVyX8SY1IA48EiTn7FzeB0LotWpvmKmf+/4xuq89LXshY
 yyY6ArZaovhEv+37S5XPRRBWD+TSnqrDr46f3QoBvVvKJsJ1aHhGFGopbIGxVpc2I8gS
 qfbZ4kYC1286CO5rk9mv7/OfjP9ZrHBjf3b83c71syUNtRT3/aLxaqsfpFT1cS1e2dC/
 NjAOr9JG8WJprujxKhW9dkr4lnMmLyDnetAGDm8iysNai7m6ag6b4ayK6MogrwohYROf
 U2+30o5oOORaRHueECpeexi+Q/p3MdSjJFF3E8AqbK93YGDaG5NURx1H1Q36nxHnXo+D
 Mhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751220020; x=1751824820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHeF7WlFhuhAfPA2ohYAhUc06q34oX8ItkPcCauHxZc=;
 b=khJwCcoqqy6YbbybMJfPE24iyCEEVKkZZ+nE20j3qOI7kKdKsTUzLDi/V2dJOrtd2k
 teieic97p3xPsO+/yy3f+2cuGyu4D448PWuS2tjcyMA8lZFzfecQPFXa+sHNYEjpII09
 e6n1TTFJJZkQEy6jtB93cOrN/AkVmHsCD2AAE4pmpuad1BjHhRC4O18mpssDOpsteDSI
 Vuyebd9fjM3tKPAAJ2AXngyT0uEUYFYB+pXU3BG4JwsRhdSv7JGUpvNmh4nej6JRiA7v
 HYanC9WzoU3Hd3cHAHJe/MpfW+maR8v05OMy55VYXPgDXZP8jf68SDg8h2fgIFeTUW5A
 Z0RQ==
X-Gm-Message-State: AOJu0YwiMXmG+ZW0lHVgCqkX+TLtvNsQNq7PP1tY4zflhp6CW2iPjcgk
 SE02IAQccmqKfqXQKwEMmRZJCrkzlFcZWxJIcF0oXZlk/M/d5WRfx3QgsNUVkHTczl0=
X-Gm-Gg: ASbGncvo1iAZTYiomfN5yqQLmsiX/f+zySJWHjzyVhmj5/KkOb9oqRnzyoNk2CBx6m/
 hYyobRYtiP22F59DVhKsGUMS93jExULG7kv+54oa9+O27rSlBNww97dTfxDBGUa+Crih3oyv1AJ
 dq5KFrkSgaUVw5vO5Rrz55B/Ul/t7BuY3/QlnMIj4L7oKQtLVnA8L/v+xl9vCYhYZpvb9K2qL4W
 Dh6PQy67m3hIEh8oaIoxT1f2Kr2dU4R+JGCUg0c1zu6BpjohcEe4b1wNEQ6c0dQgsIVgwE6RxUq
 4B6I4UWhetXprFZ0FYW+JqIUYOwCbEAvqlm+31z4s2jytgEermn05Ig6ATVUk2z8R6To/FbV7w4
 +b2ewGxlEzYt3QgNdI6konq5QP91z+FEm78m5PaQ=
X-Google-Smtp-Source: AGHT+IGEPiOPqE89Ll0Xws5Yu/UVYXqT1gWkzgC2E2GU0mGc+iyMGIUE1vxduH8m1x7CxhjkbdEKtg==
X-Received: by 2002:a05:620a:470c:b0:7d2:3db:6816 with SMTP id
 af79cd13be357-7d443a07613mr1680069085a.47.1751220020589; 
 Sun, 29 Jun 2025 11:00:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc5ad60asm46219561cf.81.2025.06.29.11.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 11:00:20 -0700 (PDT)
Date: Sun, 29 Jun 2025 11:00:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, gongfan1@huawei.com, Feifei Wang
 <wangfeifei40@huawei.com>, Yi Chen <chenyi221@huawei.com>, Xin Wang
 <wangxin679@h-partners.com>
Subject: Re: [V3 14/18] net/hinic3: add Rx/Tx functions
Message-ID: <20250629110017.32d4bfa5@hermes.local>
In-Reply-To: <20250628072552.1311-15-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250628072552.1311-1-wff_light@vip.163.com>
 <20250628072552.1311-15-wff_light@vip.163.com>
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

On Sat, 28 Jun 2025 15:25:37 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> +#define HINIC3_RX_EMPTY_THRESHOLD 3
> +u16
> +hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkts)
> +{
> +	struct hinic3_rxq *rxq = rx_queue;
> +	struct hinic3_rx_info *rx_info = NULL;
> +	volatile struct hinic3_rq_cqe *rx_cqe = NULL;
> +	struct rte_mbuf *rxm = NULL;
> +	u16 sw_ci, rx_buf_len, wqebb_cnt = 0, pkts = 0;
> +	u32 status, pkt_len, vlan_len, offload_type, lro_num;
> +	u64 rx_bytes = 0;
> +	u32 hash_value;
> +
> +#ifdef HINIC3_XSTAT_PROF_RX
> +	uint64_t t1 = rte_get_tsc_cycles();
> +	uint64_t t2;
> +#endif
> +	if (((rte_get_timer_cycles() - rxq->rxq_stats.tsc) < rxq->wait_time_cycle) &&
> +	    rxq->rxq_stats.empty >= HINIC3_RX_EMPTY_THRESHOLD)
> +		goto out;
> +

NAK
Doing this kind of empty threshold on receive is non-standard.
Driver should not be doing it here.
Many applications do polling optimization in themselves in the polling loop.
This driver specific tweak would interfere with that.
