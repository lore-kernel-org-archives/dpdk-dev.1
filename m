Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45B9CAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 15:36:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 134AA40608;
	Mon, 15 Sep 2025 17:36:26 +0200 (CEST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46]) by mails.dpdk.org (Postfix) with ESMTP id C692A402E3
 for <dev@dpdk.org>; Mon, 15 Sep 2025 17:36:24 +0200 (CEST)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-b07c2908f3eso508210366b.1
 for <dev@dpdk.org>; Mon, 15 Sep 2025 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757950584;
 x=1758555384; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qc3HOsSAb4XjtZSdbZVM9OtBxynOmdgeuIMVqJmTZFU=;
 b=YkpgZsfHY3duSHyUrandYDspa5RdPI7ypg7wvy1CIZ6blC7l7pZP0jojdzGNjhdX2g
 vsye57JAU8S7ZpvRH0QCAlkO4191aNtcbg//FYjbAzhw2FszIK8ZPmOeXINjSedwbwC3
 NYCt2bLMpHudgBM7EjDBZpwWDzAeJ1NWDmXy+kcTgD+64edef0KCVD7DZ8iB/fINrxxZ
 z1ar9TTSSiI/8hAA2brt9zEmwIp4HBt25IC71Qln/sZr/4T+0SoYhHNGA8T4L1sRtPot
 bVBXk+NAUrNkWtAFYAD97rvZFJwr8/3q+XTD7IyFxH4r65KR1y4yy1AZumGOUqJnfZFn
 Id5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757950584; x=1758555384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qc3HOsSAb4XjtZSdbZVM9OtBxynOmdgeuIMVqJmTZFU=;
 b=tj8zEbUwJQ1xSCNzPhTFDnTKDiFoD4VnIRT/P/OvSbuydkcE7sjFUO0nW338Wzv5pw
 DrplxY8of9mzQcGrdQPiN7HaG33h7H8PY8hzgHivIIv4zUjNijafOs5O/5K28RTOwtsR
 PvUw8ZFV0RgVwmde7nFQzb6JHLYkPwPzZteyqQkJG3ttFuXovTcb8EOc/sFwYrbD1W+5
 6d8HH3V+WwJ35K/IBTq8H83rXGMSGzJMcvqMd/ImIvL7MsHIZ/QD3CWxU+O+xDeAjAf8
 s5nQ+EBu/HQeIjU6uoH/p4WMMhksEGR8b+dKgE4jKs5WLNisTR/JiQ7l5hq7SdQiVN9O
 LYow==
X-Gm-Message-State: AOJu0YxqiV1ilp1FF25wqqQ9Wb04qqhFP1zELT36mMB+6yfIpClEAGbf
 //AdZIkxNj6Z0Nn8D/f+qV76AC8Rpeo4eWxUM7uZ+TVhxLOjYX8LLmWfIM4IXrIC8PU=
X-Gm-Gg: ASbGnctQBI0CaajmjXGF3PAeNhX+GPcfsqVb1/NNPxNWsKPo4gRmEVTw680vxz+IXAL
 G1aEBLgogY1GfHfBHErh9Urr2kcpOfv9Yoa2PAL5jNZW2hJbIH8CAS/DYcbnNEGnAGMT1uNYPqt
 7KfFf6btvAe6CQo35WsNqYBla0XObSeH9mqhjZ/T5pz1aPAqlrP//0fgd1Fwi72ZgvPTjXvanjH
 NDiaSXzP69t8rgMb7NxKdkNlGXVHnRnwW9EfhFxECEQH3tSAFZ/mhNeBa0G7dYV4j0AR7gN1SDw
 0GqQgV6NKJDtU8HOH7UItwv1P6Elm3Jucb2SbbAuhDyPVNmFjlsfj5oNetS/fv8a6FfPvPeU3mF
 +a4sWyVrvtnfRQutYTRRb9CEVU4FQBM8rRponJbHMe42OuuhLWuF+Ghd7k9ovJbfWeW7hhGMOWq
 I=
X-Google-Smtp-Source: AGHT+IHn8UiGnOCxzPl/vj7/GgQB0SCORo6MWsj9Cowm67f4k+FsL1uUp6QB8MxIcY28wN/D54KMaA==
X-Received: by 2002:a17:907:869f:b0:b04:1b90:8d81 with SMTP id
 a640c23a62f3a-b07c35fb50bmr1335263766b.30.1757950584198; 
 Mon, 15 Sep 2025 08:36:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07b32f2098sm982753266b.74.2025.09.15.08.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 08:36:24 -0700 (PDT)
Date: Mon, 15 Sep 2025 08:36:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ed Czeck <ed.czeck@atomicrules.com>
Cc: dev@dpdk.org, Shepard Siegel <shepard.siegel@atomicrules.com>, John
 Miller <john.miller@atomicrules.com>
Subject: Re: [PATCH v3 1/4] net/ark: add PCIe IDS for newly supported devices
Message-ID: <20250915083618.6573c808@hermes.local>
In-Reply-To: <20250915150204.1719628-1-ed.czeck@atomicrules.com>
References: <20250903212846.268492-1-ed.czeck@atomicrules.com>
 <20250915150204.1719628-1-ed.czeck@atomicrules.com>
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

On Mon, 15 Sep 2025 11:02:01 -0400
Ed Czeck <ed.czeck@atomicrules.com> wrote:

> Update documentation and release notes
> update link speed capabilities for 200G and 400G
> 
> Signed-off-by: Ed Czeck <ed.czeck@atomicrules.com>
> ---

Patches queued to next-net
