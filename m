Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1D8CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 20:50:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B212B40262;
	Tue, 28 Oct 2025 21:50:37 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 214384021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 21:50:35 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-26e68904f0eso69453845ad.0
 for <dev@dpdk.org>; Tue, 28 Oct 2025 13:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761684635;
 x=1762289435; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JfXNI0XT4RJ+PjyT6hteeLG6DqgkkcJMlRFmaQBWPRE=;
 b=SwxKem6q88ByGTZMHicZbwRguxvUfNtoy3SI9cPnu75mhmbjQ0knaDMA4jxgu4SI1N
 1pPWctbKyf0sBOXDM67zUdu0BakuYiERJermtHb+kNNuNBdGsvBsPzWK8kxLZ67/+ofR
 nnaCxWC3cBtpZAsHP7vOaLD+xe8I/AKqA+O8sBRlioCLjxamWqbZu5MFaVSYCW/irdKl
 wJHhUKkj4jRClRP/2eU37E2lhwlPmnhmLX6pYGHLAkZravg97HaPRogSkIQ8tcHbZbhG
 lxXCHCETLC4bJOjv9Vkr5DU6HdqeF9SdClRvGj67gRHhpq3vzzBtVJrTIETliESOBhcC
 ffFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761684635; x=1762289435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JfXNI0XT4RJ+PjyT6hteeLG6DqgkkcJMlRFmaQBWPRE=;
 b=F8VF90ev6x3FvR8IVu2D1HiARlUgijOD+A0HsC8YacyODuMxxizEkbQk8RoVqfsSmC
 9Gf9jHoSX4F4ZX3eI3gz7wwfKugsqrS1KbRUbznQqBoscRJIFF7N3wPbhqrLo7dZBTsa
 7xO2xldDDyWFP9XyNeZmC/15fsS79WKNhjZBNkLPQlJryNzMgr3vSgWRzl2dT8vOUDN9
 CvtWiXLNXeExQ8fR/nqRGl4XUEM+uZnAo10g5kvXp8alLYvwFLeb7KD2R6vd+J1tlHWf
 I1hmKYEscRHrt3q8Eo323pYeoNneayIszHGy4TcTwlUa4Oo0f0UFk3XNNt70C0ifYLLb
 AZEA==
X-Gm-Message-State: AOJu0Yw3tJF2Ur7dEYwrXKsCUWBHyeneYNEp+Nqd3sKsMpRrop0pt/SC
 +52IGMRkYfwJHAgKPgkA6/PF9k0tL0peocCUzyTqenmpxFYnnfzyaYpRE32yfGWUvuSjkA3l7y9
 35n96vjI=
X-Gm-Gg: ASbGncs3piG/XIEdcvhMHwdb1Yv24rdfqTTeZNac++a3aaLoHEKByH83bp1XyobU6O0
 dn9VuZXI39TdCfqjo+cPKkysR69cS6NwLfTfWLCpL5XchRgoUpV61/YXR1cxwYGNgOyHw8+2mWa
 XuqnLHwxtzE+849doGHEpt4Qiw6TCjapRidhfS/Q2lSn52182MJX9NOCCXKun2mRF7eQ7sTytWp
 eEaQ1gIj4Rp02Ti229+8vg+7JLmClw9Xn2I0a0vyQCvLbaFQBew0VjZsbWlIqL9P/LGBFcjx7/a
 7pyo2ARJ4+ARGaZ8KdUWHed2XCPONGxlA//F4PRwWX7pgd1d4GZIfg1RVd6liMAJUt1Usaxul5E
 L2MOPPDPJE2y+t0QJQNAZDnmzvs0xD3OmxExok3pqdkdX8ieGYgbpXKcqF1XZugkp0v02CeeXWL
 BITYq8pdvFFQ8bQFQ6E+TYqLqmikL5ZXj6bA==
X-Google-Smtp-Source: AGHT+IEA5G092Rp5MsM5ZpHwx1UrCIvAZr1mUDJI9XSlbaYzWIVKBnYAE+46Rdi7/ybFN+/w9UQRpA==
X-Received: by 2002:a17:903:41c6:b0:28a:8ae7:4034 with SMTP id
 d9443c01a7336-294dee2281dmr5103305ad.25.1761684634753; 
 Tue, 28 Oct 2025 13:50:34 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498cf35a5sm125624705ad.18.2025.10.28.13.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 13:50:34 -0700 (PDT)
Date: Tue, 28 Oct 2025 13:50:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 9/9] net/nbl: address channel Incorrect expression
 issues 490958
Message-ID: <20251028135032.70f467cc@phoenix>
In-Reply-To: <20251027101649.3337618-10-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20251027101649.3337618-1-dimon.zhao@nebula-matrix.com>
 <20251027101649.3337618-10-dimon.zhao@nebula-matrix.com>
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

On Mon, 27 Oct 2025 03:16:48 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Coverity issue: 490958
> 
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> ---
>  drivers/net/nbl/nbl_hw/nbl_channel.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.c b/drivers/net/nbl/nbl_hw/nbl_channel.c
> index 654e56f200..acbceecc46 100644
> --- a/drivers/net/nbl/nbl_hw/nbl_channel.c
> +++ b/drivers/net/nbl/nbl_hw/nbl_channel.c
> @@ -856,9 +856,12 @@ static void nbl_chan_remove_state_bitmap(void *priv)
>  {
>  	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
>  	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
> +	int ret = 0;
>  
>  	if (chan_info->mailbox.state_bmp) {
> -		rte_bitmap_free(chan_info->mailbox.state_bmp);
> +		ret = rte_bitmap_free(chan_info->mailbox.state_bmp);
> +		if (ret)
> +			NBL_LOG(ERR, "mailbox state bitmap free failed, ret:%d", ret);
>  		chan_info->mailbox.state_bmp = NULL;
>  	}
>  	if (chan_info->mailbox.state_bmp_mem) {

Skip this patch, better to fix rte_bitmap_free() stub to be a void
function; addressed in another patch.
