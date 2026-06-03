Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E78DCD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 21:43:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9446440663;
	Wed,  3 Jun 2026 23:43:45 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id BA198402BD
 for <dev@dpdk.org>; Wed,  3 Jun 2026 23:43:44 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-304f590dd91so6070506eec.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 14:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780523024;
 x=1781127824; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9uTxAgHg9XvXngyD+QFq0r35HKEo15kDNhBGFqPRww=;
 b=qeTkLDfnMLXWQh3k8iNJhVMHc2RtnL4P89NPX+fT8QjJbI10Fw+IJB6yyLWcMXSHLm
 PG/lPar1EVVYurA4mdMHRvu7BCT7kpkWJX7zxhNFgoxqimNmGjVCXZkmRnML8vLDDOtP
 BOGTx+CIqJxANpdkJf74NwPDNjtX9USLi8rh/y/DH8jZzifB3z0UkXJu21X80IuQ4CM5
 cl7Y/gSwgR6dk7PZsVAXqf/WHHqshTolXKEgvTC0k3w7rlGcWlBUOfMNscYv7OPR8etC
 eej18K2oIqwtCE0qr50XJ/EJ6af88XFJGvgY0AXE+7B0kDKG5giuJ3WlDFmB+sgxdNSl
 tlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780523024; x=1781127824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t9uTxAgHg9XvXngyD+QFq0r35HKEo15kDNhBGFqPRww=;
 b=a7qpZiwHFsqITKEqYtB07bHfTwE+gTJJCEUK98H3uTTfPM1OfvBceA34OGbzYf44PI
 YVnOi/xCuGhVAadGFGseP7JYyBpahjAHnCgiLkL7rCpvxrBsZ3u2e73doyt32kALPdpG
 MGX70meY4XEl7DN2c0erBwVfJc0MZ2gKbKRped6ve2aQBolvZCQfSPEFMpPrxhv2m8FN
 ohQSzBSLUpNP3Xus5ojxEClznB+jgo3aIFFhJhKVlcJKzBMmIfFxh+HgVtc6yDcFMRA7
 MUayIcep6q1KfBrn5ZlqRkTRom7XbHX9ywP9xqp2BH9tUfCaBHtdhrCaFfZ9Au4w/CxG
 7GYA==
X-Gm-Message-State: AOJu0YyyKZSW43MTGK82wNA/u24qy/FHTW/he8g9jT6Tjnry6gltZSut
 Kz072UkCxm0OBM75BHdHmq4/S1UTkt5XGV8do7A6zcCVpxbU4crj8Xklx8Ot1M5JjnA=
X-Gm-Gg: Acq92OEhn7sDw8/cYFQZdhOQXhbl9PaIQvqniLuaHyaAXB/R8yy8hxBX2vKtdLjn6qT
 bq593lMNRFeUUXUg989o/2Q0TV0a7qmNPV3Ov+W2hXx844cK2Z5eqME0vsALRPv7sykqGB4ND2Q
 SOIsqEmTpcfFasw/c6hrlNL5hgyvXf7IhKKhA1zCSdTPAzMvd+XsYKmvvvg+7rcBx5XVoPKsUKT
 bEiCKSbVhIjyw0cZ/sCk7zS7lrx7D9bv+eEg6+cW011qVdHjjPCLZUMvzs8kp84PIbHaIAsoXbt
 1JO7Lfgv9p6/+b0TjKBsbmktHgo1tqR1t+TX2zokeigkf4qXHxAs8qBi4GBbyyMrFSN5CkJEam+
 9/MCLIzXGFqPqD0f6yKlLiAo6FcWTBm9RT3aeoE65eUAdmwP9JK2AOMv3PZl9bBfu5kaVVnS/2l
 R3bjTa/JaGbnNVIQxOqXnCceqcxxPPrYeaQ2eFUccK1SkpULxk7WNFUevwszkU6xpyfQXcZnjqA
 6ClqwNdh9Bvgw==
X-Received: by 2002:a05:693c:2c97:b0:304:caa4:3559 with SMTP id
 5a478bee46e88-3074fb4a3f4mr2877489eec.22.1780523023777; 
 Wed, 03 Jun 2026 14:43:43 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df3b234sm4532436eec.23.2026.06.03.14.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 14:43:43 -0700 (PDT)
Date: Wed, 3 Jun 2026 14:43:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com, stable@dpdk.org, Keegan
 Freyhof <keegan.freyhof@broadcom.com>
Subject: Re: [PATCH 1/5] net/bnxt: fix NQ/CQ processing for interrupt handling
Message-ID: <20260603144341.23867ee2@phoenix.local>
In-Reply-To: <20260603211341.2112344-2-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260603211341.2112344-2-Mohammad-Shuab.Siddique@broadcom.com>
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

On Wed,  3 Jun 2026 15:13:37 -0600
Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com> wrote:

> +void bnxt_process_async_msg(struct bnxt *bp, struct tx_cmpl *cmpl)
> +{
> +	uint16_t type = cmpl->flags_type & TX_CMPL_TYPE_MASK;
> +
> +	switch (type) {
> +	case HWRM_CMPL_TYPE_HWRM_DONE:
> +		break;
> +	case HWRM_ASYNC_EVENT_CMPL_TYPE_HWRM_ASYNC_EVENT:
> +		bnxt_handle_async_event(bp, (struct cmpl_base *)cmpl);
> +		break;
> +	default:
> +		printf("Port:%d Unhandled async message %x\n", bp->eth_dev->data->port_id, type);
> +		break;
> +	}
> +}

NAK
printf is not allowed in DPDK code, use proper logging
