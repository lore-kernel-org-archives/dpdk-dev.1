Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0438ECD9A6
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 21:30:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D856A4021F;
	Thu,  5 Feb 2026 22:29:59 +0100 (CET)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67]) by mails.dpdk.org (Postfix) with ESMTP id 888304021E
 for <dev@dpdk.org>; Thu,  5 Feb 2026 22:29:58 +0100 (CET)
Received: by mail-wm1-f67.google.com with SMTP id
 5b1f17b1804b1-4801ea9bafdso8731325e9.3
 for <dev@dpdk.org>; Thu, 05 Feb 2026 13:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770326998;
 x=1770931798; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=kgOrxKDWhziICp9+cwgF5G3vI/uRS7EsuwQWLXJI9dg=;
 b=diFvgk3hBbA331vAtjbGIGstvCOu0vOeejmuE0Sp1IdDxO1Pv6WOwJK0tLwPTzEjUO
 S5k2+/XznVU8q4Y3ZCENMHYYQHC2xwXQqJ3dhMwVOrV5LM4IXcX25/Y/YS48qP8EYilk
 jhdTRu3gwpy5gUTrDZVO1k4CPiDVKg4PE+oSqeSetdDLmXcwh1aKhymKUZM+5kSJEVQ2
 U+cTsPFEsycrgQSQPdBvJFsD/JqjoiaiKpN1f3JTNig4EoIEG+tlG6RmnaGDnSGZMbIQ
 p+G//CA4xF+xR/YqXMMjoOSVvaKKznapLleEQjlnVJJ9ZeSquhSGDMKT1zUyGIvgG0QV
 SzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770326998; x=1770931798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kgOrxKDWhziICp9+cwgF5G3vI/uRS7EsuwQWLXJI9dg=;
 b=dIkizR3PtuyW+wZAS7g6/fBrbcGLhTIw2UEElblxm8kloCVigRaBT3Oy0pG0OPOPNx
 pMg2rDG5ns0+/RuxVtjJKCXotjk0eN+yAVuv3DNcteMgrRovDfZW0vCOlG5y2kTOgZSx
 75hMYHphHG003zR1r3wBo7Hr8L/DdLho2uHr7Mnqf6t5VEfcQgx61HUQSm3qkVBU89En
 pMfNv13rBxtxwYB6llJaUwBZU70fYcTbfe+VI7boZ15LlJt65ORC6rDpAOXmW0ybxcAd
 NJ7nAoD/HcXh9bOf/MKw/+o7j7N4MFG+aaZzjDVvM/Izlc2t/wKJfv4ION2hNCDxptUA
 P/FA==
X-Gm-Message-State: AOJu0Yxc7/2wRSMS8P9SSGZnlXALJ8N2vXRpbCdZ31WrJsIzopXcYuVZ
 Z1jl7WSJ30ReyvWsFxz2/cFhO0QfMj6Tj/MwI1VRXPf3S3Yj7DTBVp4EoASTbZDIppbg/+fpdQK
 8QH/ehkI=
X-Gm-Gg: AZuq6aKKQg8yH6z/5WpoKGVekeSV3VKu0DJx1EMIurwYJn4Z5EzoL0xrZ/xyGh66Fj9
 pHs2IdXjtn8utD4hzMjRYiYYg/89TcbbKicRP+fxT9zjReSgZ/1OE36Rhskq2hyNR7KNQYLwyVU
 wI6d/hRLCEa5+vn5cbeEzVPIvHr9nnUUc/5KEPN9ABD7l5JGDLLqel626oTZ20rkwYEzLEQO/1e
 LjK07ARiTzEYezqC0VB6vIHiuurH8DUpQ97JdK39XY+q0cTIovv3D5Kg8dU7CLqKFziWZ7ND8Zq
 dcuR8AN1JpMfnk55QFkgshS9bH8FVXPIbxZ2Hz0pNNxTVzpQa32MLErFL/s0Vj1F2E0Gbi2FB6e
 G9HXSkcotBM7VbASMIrVPsnm/Y92tDwxC+NIrXdx+alAMzOwrIlSn2naYRLnVIZYR/rW+nLQ5JC
 P+srKvIaAeKmok3rPZYac1FIzhHF389mPC9kV/fN38KbNLPwSWb3Oe
X-Received: by 2002:a05:600c:8b61:b0:47d:3ffb:16c9 with SMTP id
 5b1f17b1804b1-48320966711mr3352535e9.23.1770326998090; 
 Thu, 05 Feb 2026 13:29:58 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483207286bcsm5977575e9.12.2026.02.05.13.29.56
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 13:29:57 -0800 (PST)
Date: Thu, 5 Feb 2026 13:29:53 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v2 0/8] doc: ethdev documentation grammar and typo
 corrections
Message-ID: <20260205132953.0d1df590@phoenix.local>
In-Reply-To: <20260128194722.480862-1-stephen@networkplumber.org>
References: <20260116213100.110419-1-stephen@networkplumber.org>
 <20260128194722.480862-1-stephen@networkplumber.org>
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

On Wed, 28 Jan 2026 11:45:59 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> This series corrects grammar errors, typos, and punctuation issues
> in the Ethernet device library section of the DPDK Programmer's Guide.
> Initial work on this was done as part of review by technical writer
> then more changes as result of AI reviews.
> 
> The first patch provides a comprehensive update to the Poll Mode Driver
> documentation, modernizing the description and improving readability.
> The remaining patches address smaller issues in the rte_flow, QoS
> framework, switch representation, traffic management, and traffic
> metering guides.
> 
> v2:
>   - Add patch to fix minor grammar issue in ethdev introduction
>   - Add patch to correct alphabetical ordering in ethdev toctree
>   - Add patch to fix grammar issues in traffic metering and policing guide


Queued this to next-net.
