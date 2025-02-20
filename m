Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AD0C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:32:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16C1C4065B;
	Thu, 20 Feb 2025 23:32:01 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 07FDB40609
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:31:59 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2fc1c80cdc8so2448452a91.2
 for <dev@dpdk.org>; Thu, 20 Feb 2025 14:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740090718;
 x=1740695518; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8vJPK21UFpfBE3X5UOiITQXDj6Kodegry8sZPpRiJSg=;
 b=u1XOfy4vcL9GMXbC3Tv5cndCbMxrRX4tgqgKhjeXblQg/ZQxcw1uqDR+LxrGMxCiUC
 4lo/vN6P1NX9qE3d3aHTgH9iaBHKcyco05RoXfoA9FJR1ggU9iqa8HoGJCsiH3IQSw70
 385M+WRjFsK0tBgi//mayu1wH/sQqsokKw9ev/t5I6/gqIm2yTves+9j5Wsq5uN1h8HB
 QNhqDwtmWPmKNQPmzW/K4KGV2DQMbY9ZkKhW+RYfUo2ktpakexobqtSW2y0+dpdjYg8k
 ARPyHi943anJJ6AxaRuoAwC4sWJrYc2BmWGspvN06/UnL4oWRo7AFxR7FuCWITTH1SXE
 Ku4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740090718; x=1740695518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8vJPK21UFpfBE3X5UOiITQXDj6Kodegry8sZPpRiJSg=;
 b=RS/6zBspdnsWrN7HNZLW5HBNPP4Fyecyffke+CDX2iAz8hix6tphMlFnaESEunWdzl
 h6VqonSPrTRabxg5ELXctDSo2hubYPFVLrxmHFeimeSaZzQn3yc6Cvujmrjf5V38BCkM
 hgb4s8oBdEayff45RdUp4HRlHq9UBefngyUZxqtpb6nc1NP3SpN/g6BfMdg+zV5gZrhk
 qYBi8lILa+qo3hQYCnpCCIBZYEQl1WbIHc58B7Bw4SXGJmTMZKYdqV5hR73sMomLVSus
 Ha7opIezUB60UAQNqgCFLeb4uJqCM0mWyqCSQv1FXkTIvISCOhx32+cvY4rq7ZGLpiFn
 E2SA==
X-Gm-Message-State: AOJu0YwVim4saC0/vF/NAnT/ene4NgE33OPc+/sAz6AKULi5gT2lTyMW
 l0d5mCfRK5/xCXY1I7QK+jySVpEGdsN68LueHw/kVV7E+pJiV+KfeoSHE0VMDCA=
X-Gm-Gg: ASbGncuGz3uGZdeV/ct+/wQIUMq9lg9WdCooD43axkCwDqKfFTlGkZ6NytIthnem5V2
 cgG8XGTNUKEcfEt3fkCPTY8oGY7516cUtVtW8yKJU9bLEnuWpPZ5ydxIDKFaCHSJUxjwLOyRYy6
 WnXDGw4dMr2Xxy5mkUcZAf0OXLaWG/iymND04K53VrKlFSB0TKqON5Lw10IjtKprFpAARjueaWW
 dnvO/tbOgmCpRGmm3isS64r7D8Fq54oJhz8kRYL18xsZvZSa+DyHwAQvI7dgJSbFx0IQ8AYFgQo
 o8+f9a65uZ2fzug8RhLjpxYROt9SvukO36JuIYBs53ygEp6LNxk/PpzT4Q6AflDfc9HR
X-Google-Smtp-Source: AGHT+IEtoAKjlPXIG82F83iKwIO/k3NKVZ1zOgCSLlQfm15VUD3W9QAjx5uUQhVL7LTPVqz7HTTy8A==
X-Received: by 2002:a17:90b:5688:b0:2fa:f8d:65e7 with SMTP id
 98e67ed59e1d1-2fce769a8demr1513626a91.2.1740090718005; 
 Thu, 20 Feb 2025 14:31:58 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf9ab049fsm16531983a91.47.2025.02.20.14.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 14:31:57 -0800 (PST)
Date: Thu, 20 Feb 2025 14:31:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com
Subject: Re: [PATCH v1 32/32] net/ntnic: revert untrusted loop bound
Message-ID: <20250220143155.1f74163c@hermes.local>
In-Reply-To: <20250220220406.3925597-33-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
 <20250220220406.3925597-33-sil-plv@napatech.com>
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

On Thu, 20 Feb 2025 23:03:56 +0100
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> The changes for untrusted loop bound breaks VLAN processing
> 
> This reverts commit 36cd2cb0eea49813dd59ee1df2eb592e8ae5b6b4.
> 
> Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>

This will bring back the Coverity bug and potential for VLAN "packet of doom" bugs.
Any loop iterating over VLAN's needs to limit depth
