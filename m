Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65943CA1013
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 16:39:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31FE0402D1;
	Thu, 18 Sep 2025 18:39:03 +0200 (CEST)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id 94CB240288
 for <dev@dpdk.org>; Thu, 18 Sep 2025 18:39:01 +0200 (CEST)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-795be3a3644so4083316d6.0
 for <dev@dpdk.org>; Thu, 18 Sep 2025 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758213541;
 x=1758818341; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sW4xRdeJHi+G6EQ6lV3oD85xxZ2x2XUWW+sk0VByi5I=;
 b=RyA4TY+p5sDOKCubx6U/vIAj/fh6YddtTGzpPqTvecJCYSZxmYZgse6pTcbzsB9szy
 cXemuhoYfuENr5sUngEyQwSFEiBt1b1jWzyzeOMHIanimc7JrYrQRFuDjH0y5khRawbu
 EAgIbZ8j0IXgwVRXrFh5q73F9HQsAi34s7WcuR8wu3kog0OHLtbudiYcCb9cIxjGHBzd
 LlsOwlUyWp/77eLrAGbBgcch5+UbbhamfLvqGR7xO5hgDafIV45sv2Dznp+WUVBhgEK9
 VO5wKc21t4E1NVsAtYQzOX98s9ejhUL9Yd8OerM7QsXPf0xIjnZd7aDoKAs6zIZqCQlv
 0jMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758213541; x=1758818341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sW4xRdeJHi+G6EQ6lV3oD85xxZ2x2XUWW+sk0VByi5I=;
 b=Fra/m3gWSnGGHtExE0RQyToBI2ybQ16Wo5NwtIEx6eFcm5eu4NIsCoscQwmDpGvHl9
 qcKapUEN9YwJHYzSKqzyiAi6BpOkx686MBuk+YEyjD3S6zmf3BD2cIG6ria/Htg/KFsP
 C+tabWiAL+XunV3FXjkwm0Regcgkuz+g8kDsdIKrugSkaiyXrIaQUGOTEQ+bP8h+cqIQ
 nmja3qAuJHApNu3awnDxGteCoZHBiBukBn2zCE/mMVl0ErpuWhc8UXLucbkx9OwvXmLR
 932TsrYFiu1dx1AR7Gmb1VEHopJEO4tK6kipI8By9huuRHW5f8oOXG/9RgYM2Dx0G/1c
 AJkQ==
X-Gm-Message-State: AOJu0YyUN/gdNYmSrGKcicnksOfX1sZEXzO7IW6NXSGcXL10wYcg1LgR
 Kq5UOC8q1HkeMenPw4wDTpyPgcrzwvJw37Fb6MVLja9xRwu/jpE0KGi8sEDMl9Z0K9LNC7RFLP0
 BxjRZ
X-Gm-Gg: ASbGncsXXCX0L1dsQu7BTI1bMDLbmxVeKZY3peJPb4Eo2mUBpFCQj683oQo7NZazMoh
 SKC7wi+h9Gar5i4Y7CpcxwdmgnYBiRtO60evgli5uwMa8uC965Tb1OHYoV+B7pdXCSV3fAesUpA
 u9SJwWOKd178Ook39CwteWYQZuBF9u0wxUc+PFo2E/FaD7XvwRI9CZUYK0pgytA+51jpIKSS7zI
 gyn8o7Glc/Vac2yOwYNmWsDbMSZlaG8aNSAQK9M+hh1p3nn1w3CZcTfX0gRrdApb4AbOFg6ieDF
 jbtxDTLGl3SgDEfLkgsq3uje2wG2+uqVJJ8GNr3DNUKP2LegHgyeMdTeDvOwkLBMeyT4KY448dK
 8h5e9oIxNTicOKIx7mogsEsLZbf0MRh8+P23Odk7gCoxzbEF+vunluSnIOAstH476Yyc2z39xU3
 NdBPAGh3mGtBFjAu8ZEw==
X-Google-Smtp-Source: AGHT+IGf73GwpUNtYxHQp4XnXZ/Y+g5E+sbRgGXjju5+hekSiHcQvcFTzJ03TRFOXJk3XjvPow+x+w==
X-Received: by 2002:a05:6214:268b:b0:78f:1a9e:2590 with SMTP id
 6a1803df08f44-7991c124a4amr823756d6.34.1758213540493; 
 Thu, 18 Sep 2025 09:39:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7934636f947sm15099276d6.16.2025.09.18.09.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 09:39:00 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:33:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v9 04/17] net/nbl: add Channel layer definitions and
 implementation
Message-ID: <20250918093317.59c4cce2@hermes.local>
In-Reply-To: <20250917080843.646050-5-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250917080843.646050-1-dimon.zhao@nebula-matrix.com>
 <20250917080843.646050-5-dimon.zhao@nebula-matrix.com>
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

On Wed, 17 Sep 2025 01:08:30 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> +static void nbl_chan_recv_ack_msg(void *priv, uint16_t srcid, uint16_t msgid,
> +				  void *data, uint32_t data_len)
> +{
> +	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
> +	union nbl_chan_info *chan_info = NULL;
> +	struct nbl_chan_waitqueue_head *wait_head;
> +	uint32_t *payload = (uint32_t *)data;
> +	uint32_t ack_msgid;
> +	uint32_t ack_msgtype;
> +	uint32_t copy_len;
> +
> +	chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
> +	ack_msgtype = *payload;
> +	ack_msgid = *(payload + 1);
> +	wait_head = &chan_info->mailbox.wait[ack_msgid];
> +	wait_head->ack_err = *(payload + 2);
> +
> +	if (wait_head->ack_err >= 0 && (data_len > 3 * sizeof(uint32_t))) {
> +		if (data_len - 3 * sizeof(uint32_t) != wait_head->ack_data_len)
> +			NBL_LOG(ERR, "payload_len do not match ack_len!,"
> +				" srcid:%u, msgtype:%u, msgid:%u, ack_msgid %u,"
> +				" data_len:%u, ack_data_len:%u",
> +				srcid, ack_msgtype, msgid,
> +				ack_msgid, data_len, wait_head->ack_data_len);
> +		copy_len = RTE_MIN((u32)wait_head->ack_data_len,
> +				   (u32)data_len - 3 * sizeof(uint32_t));
> +		memcpy(wait_head->ack_data, payload + 3, copy_len);
> +	}
> +
> +	/* wmb */
> +	rte_wmb();
> +	wait_head->acked = 1;
> +}

The C11 atomic (rte_atomic) model is preferred over using memory barriers.
In this case you want to ensure the wati_head is updated before the
store to acked. That would rte_memory_order_release or rte_memory_order_seq_cst.
