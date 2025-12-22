Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7ADE67808
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Dec 2025 23:31:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F9B7402CB;
	Tue, 23 Dec 2025 00:31:23 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id C37C240265
 for <dev@dpdk.org>; Tue, 23 Dec 2025 00:31:20 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso34781325e9.0
 for <dev@dpdk.org>; Mon, 22 Dec 2025 15:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766446280;
 x=1767051080; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=492wpApSEG7sfTBMeHI7gurerxYv+Ga7f3id9SLMLhk=;
 b=dftsye5ygqlarhHAjbUeyKqp0dRe9l5tvHJLe17Q5kHjYFcUHzjTMESwS7qw5TAMZb
 n5nd0A767m3IBc6Y0luDq4xuADMgVByrWygvICKP9trSjSvT3gj3xmdI0qcwndSoB7L/
 L2M6e458ks0URCMNkXc7GFCinwkK2opZrMHLlGKWNAIePWb+PQV8AdPsX1KF4hRLkTr0
 /A15nHIu6LHOlAtqHOsz8zfdIxuLLxEvZewCuqx3agFyFi+BSol8InIRBllhHlGgFBJs
 o4CLzfY1DjPBn4T/BXDjNHu363LzdD3xyjPGDFM1aJLx/8Z97SYs9sWttOqYX6WSqICh
 47yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766446280; x=1767051080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=492wpApSEG7sfTBMeHI7gurerxYv+Ga7f3id9SLMLhk=;
 b=r/OcN3qCuFS5Y1hIrJd24MtyaFjjiTsZELm7T82U4suuRBWnHT4xuElnGuVtB/cEDk
 3kfaT0ilvK0zMRRB4Hor8i1Kwy6sX/uwrommtpBwuMepSyUgOW22FXsw3YkrFLJ6t14X
 ijGAL4QVrjh8LGNoPfpmrgQKJrYLLrBUVhATaG3RawESIiSSb02QQz0XE5N6nteXJdTN
 AYYO8p258lHsDUGeB6ECuXGTL9AF7jvRXFwic00UBFgXWx4XgLz9JewKPQ838e8QYq81
 lFgEl5bvO3ECz5hn06gQXJcSA3eA/PXWK90a4UPDTEedF/D2wS7oVQgqbGYvtCFAuNT3
 mMeQ==
X-Gm-Message-State: AOJu0YxGROIEsJzHCEowWRoH1lWO7KX6SfGCQsxW5yxi+erR8LqISMXZ
 e+l0hD9M6sXLeciORpDtFwtIN/FT0EInr0Q7ZLWniwiV4FXZMZBKHSUEom2ZwdPm4T0=
X-Gm-Gg: AY/fxX49etNp0rO9KTvyAMmdlK6XYYvm05vG3NqXZ4YrPSDmT2ellj0WNbHA0Gl7YHq
 WRjWK0NcuUCNW2sGX7TSVI7th7BvXfNpSvLxJE9cFeJb3hXBaoU7QcjNFl+oNgqN78KJqvCir/h
 vaFHnBkZ80+rcCS966h4HeTIK0LEcfyrG5X0BPKKIC2i4FMQBSVA4xgVc+dK6lDuNjezUbKZcnA
 1NQkguCDGic6psMZBD3p/qLwyCAMgQ2rP23OcoFWn8VZq4eFfPlEIsoPU4X6E4G0W2GUOUTJQuG
 dV5QvQj2BtYvY+3VmJLo4BSWIXEy2kLkaqUXCMy5G1BxdsEre7aJAcC5HsgwRjYT6sttjyLFSsO
 gYTUJwRvu4bqokvjoMNEOE2O3z5/XeVhhDOQR+URJW13K7SQLPR1gyZTTnwzaptuzLO1g++6IS2
 iBNzroiVYiVGRBV9qI3lWezQYHdZeWg4GVmK65kOv4LweBF6wcB82t
X-Google-Smtp-Source: AGHT+IH9FkvT8+UhZuX/ejDw/AahzPr+ZZTMSZ0QsXc2Q3SIKsn+A6w01BkZ5fALNDLAO5X8/n2njQ==
X-Received: by 2002:a05:600c:5489:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-47d18bd5651mr128881695e9.11.1766446279784; 
 Mon, 22 Dec 2025 15:31:19 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a4651bsm104051325e9.7.2025.12.22.15.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 15:31:19 -0800 (PST)
Date: Mon, 22 Dec 2025 15:31:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, Remy Horton <remy.horton@intel.com>
Subject: Re: [PATCH v2] examples/ethtool: fix buffer size for pkt pool name
Message-ID: <20251222153114.24314d10@phoenix.local>
In-Reply-To: <20251222083858.1035980-1-shperetz@nvidia.com>
References: <20251203110157.51471-1-shperetz@nvidia.com>
 <20251222083858.1035980-1-shperetz@nvidia.com>
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

On Mon, 22 Dec 2025 10:38:58 +0200
Shani Peretz <shperetz@nvidia.com> wrote:

> Use RTE_MEMPOOL_NAMESIZE for str_name buffer size instead of the
> hardcoded value 16, which was insufficient as the format
> string "pkt_pool%i" can produce up to 19 bytes (8 for "pkt_pool",
> up to 10 for integer value, and 1 for null terminator).
> 
> Fixes: bda68ab9d1e7 ("examples/ethtool: add user-space ethtool sample application")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
