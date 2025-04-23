Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C91C369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 18:01:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49E6A40156;
	Wed, 23 Apr 2025 20:00:59 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 5549A400D5
 for <dev@dpdk.org>; Wed, 23 Apr 2025 20:00:57 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso74920b3a.1
 for <dev@dpdk.org>; Wed, 23 Apr 2025 11:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745431256;
 x=1746036056; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SpIXUM+X8gRcx3+szDRr/6SNA9ygxo/2zIv0TZmRZ/E=;
 b=u5FVPjyL+tva1/f1AjAlj3jNsvhP9VacyaangNcrRP7mehRD4J+DIx13VuY5HtnHI5
 Pot8hoL/1Q/pv9AI9QPRoe6RNA/Ud3FRajcEjir6zdFyzH0pNdhNSU6Y9oyzEZsYVMeX
 TPqlx+e+Kdh7tO9aY3d0otK6XzylS/p35ZQWtR8POntoOdfCS3PqM9K0OeigEktCLzsp
 SB6kcrWHAyjIF8CTxYz+KWhPsPU1p3YZHsEsSWVqq/FTIQ+GncbkuAr/fypF3DMzvBSf
 krgqHNww0Sp2UTMJMzipp6SmC0Ep3Vq2BIiRMpFSLfikd8PiOKarShBoZuWn1gSGNvn/
 r88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745431256; x=1746036056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SpIXUM+X8gRcx3+szDRr/6SNA9ygxo/2zIv0TZmRZ/E=;
 b=dauSbmuqbaKAmMmWAufrfb/Inhs0IsP71PGPdL5kdGtuxCAXnmpSOkw6U7BM3i2/Gd
 nEW7R4vAsqe2yKmMti5s7XezigRdaCt44khAo7XQ060Ny7Ie0ZESf4cvDMnhxjSCHsjm
 3eC6ru6c2ofBfXSEGyk133RcmGtn2FM3IQ4U6zcRS6exVTc7RD/oAk8NZoplTd9F2OIR
 tUCX3c+PJzsf1dyFoLyahqFdURS1ZSfY27XtCyB1VIAtz6VaGjmaAH/uSJzcoio/xGta
 1u57g0/9SuK8ONHkZI5J9WN5zLZuGgUyo18CXO/WmtRqqrKWtLks102HeGTAyfO1h+PX
 VhyQ==
X-Gm-Message-State: AOJu0YwoLl77S8gl09QOHTBm1knstqOfVLEagwCLMqlgbWh6R+xCFH8F
 qXavjSH1srgXL8F3HpYnlBQZb0gIMW2wBZ/WFgCWCLbYIelG/xCBpz9t/pLbpF0=
X-Gm-Gg: ASbGncv+KJB27LdKsVUsEz6KEpN8JUvA+wTVDecWvyZSiX39gZJp3rPiuwaYweZ1z0A
 pJ0IL9jiEPyxc3AXSO8cHoN4Iia5FnEg2zLvFvQgf/Pcy3YwLuMulJhA+zx3sRWh/irQZm6ZT1L
 V8SFZ4S9+wgu1uC61EMK4XWhsB7oggivEkhlGDFh43q64OfWbun5xiHXZSywjqbW3YIcBVQN3Z5
 4T21s5zn33T8IU4Y2A8PVq7mZJ+0ZjkmgPP8a1A8N31LRk/Ff/w4ZZbX5psdT29kfCqw0JIW1bU
 lpRdQ0XyfsNu/4B7pk1L6yfBoeYLC81ZFzjLE2JmVBH9LtbRozd6R9QD5JfYwtQ8d64p5hk+gWf
 bCrc9hO0wT9PwUVrn
X-Google-Smtp-Source: AGHT+IEqcZ1awhgO0/Qle4lxyLA+/zx7EtLulAR0kVOItOnfOUMIa4VsFAjt5WFpGHgKw4W1yFtVBA==
X-Received: by 2002:a05:6a20:c78f:b0:1f5:769a:a4c0 with SMTP id
 adf61e73a8af0-204410a58d1mr580549637.22.1745431254731; 
 Wed, 23 Apr 2025 11:00:54 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfaab92esm10849180b3a.127.2025.04.23.11.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 11:00:54 -0700 (PDT)
Date: Wed, 23 Apr 2025 11:00:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <changqing.li@windriver.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH V2] ethdev_trace.h: Update the trace point function when
 _TIME_BITS=64
Message-ID: <20250423110052.1b89ad1e@hermes.local>
In-Reply-To: <20250422122956.1217418-1-changqing.li@windriver.com>
References: <20250422122956.1217418-1-changqing.li@windriver.com>
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

On Tue, 22 Apr 2025 20:29:56 +0800
<changqing.li@windriver.com> wrote:

> +#if defined(_TIME_BITS) && _TIME_BITS == 64
>  RTE_TRACE_POINT(
>  	rte_eth_trace_timesync_write_time,
>  	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *time,
>  		int ret),
>  	rte_trace_point_emit_u16(port_id);
> +	rte_trace_point_emit_u64(time->tv_sec);
> +	rte_trace_point_emit_long(time->tv_nsec);
> +	rte_trace_point_emit_int(ret);
> +)
> +#else
> +RTE_TRACE_POINT(
> +	rte_eth_trace_timesync_write_time,
> +	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *time,
> +	  int ret),
> +	rte_trace_point_emit_u16(port_id);
>  	rte_trace_point_emit_size_t(time->tv_sec);
>  	rte_trace_point_emit_long(time->tv_nsec);
>  	rte_trace_point_emit_int(ret);
>  )
> +#endif

No. Do not start adding #ifdef to trace points.
Instead, add new hook rte_trace_point_emit_time_t and that can handle
any ABI changes like this.

Best to wait until 25.11 release since could be ABI change.
