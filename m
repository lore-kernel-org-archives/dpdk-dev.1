Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7576EC8303F
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 14:47:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B840C4025A;
	Thu, 28 Aug 2025 16:47:12 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id E3043400D6
 for <dev@dpdk.org>; Thu, 28 Aug 2025 16:47:10 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-45b7d497ab9so3607265e9.0
 for <dev@dpdk.org>; Thu, 28 Aug 2025 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756392430;
 x=1756997230; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAuec8KIdzZXoqW93ZXPNnEDoeAa/wK7FLFpzxvAj/A=;
 b=WUbnz47KG1BzrcHcXRie104QjTywJP9Fp66lxqBGJjkSsXpEWs2fhn7umtaHmOHIp/
 lg8dxeNkgTjloMquPvWkLl0kD5PeyODG2B3megSt3Zpxas16cJlINCRNOHOfPIGCQw8y
 wVo20fu7tjt53akNBWzmc7LxhWxeWqKZ5fidLU9WFXOS0XjESMLeU4CqB0UNEE7hdKK3
 sVB5K/n2VBa40Yt7fqVuAQGpgcc8VO4/ll9cNsp46Gaxia6XqZReiUyg7Gsg4FFX5r39
 RBGIgusDqrw+uKvbAyW1njVigC4RdjTObV9LZIUQ5rIDKaOFd31UsLoPb4F/vgdPHeW6
 gz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392430; x=1756997230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CAuec8KIdzZXoqW93ZXPNnEDoeAa/wK7FLFpzxvAj/A=;
 b=P2fr8AYhRzAHyvkBL6T+FGRL+rrdFmaXJd2OLqiDI4D66jv9eIMHN9ofbCVYU2XIdB
 CJHiQ5hHP7ti5LSACiSMl/BDP4RGqmmhJxogauan/bJIk9tfoKArXEe/8qM20QMITjYj
 Rsh8feqMRKYUrBYZ/dwq9PU2yloPgxskZUutSesQOepXaKVdadqbbksKzAK1yxs/nPWj
 Vt+13IwCIvD5tMVup+LWfxqkFa1BUeYRVOKhYwI/Pbyj+aSrHKdaTyjlh5HRSkQsxNN8
 uhsXMJO5zoXqfw5m+GgFcqsxpUrcM686rgr6xIB5OvuC4IfGTUz7dtHtRwsAlvqZRAXN
 TIJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/davAqmtNPu+6SFQL2RK8WFMCCmDDOqHP+b3i3WUiluzvvIOTtmJztZw/3J/v68yf1Bk=@dpdk.org
X-Gm-Message-State: AOJu0Yzb9ZZafJJPaB1W1kS91c42S8sMcTmoWLusiMqts60+wVTkWFW8
 ipdmQ/qNP+dNKss5/8BfVXPyhDhJSdp+z+zUI6qv0hukqG0OiMHXhKWQtkSna10YARA=
X-Gm-Gg: ASbGnctb6kLX3ZFw0j0g/X5P2WUzveDyoaKod0B0+paisTgxu+rzhl8F/Bs4pqfvtBx
 rZiCAser+x72BZcC70OGf7YCkClnsG9fDGp7/+7WCl1iFyPu/astlf0oZp/627h4iyLTD0y3UiJ
 VumwvwEV5IOABgYaRIZ+yXxPD+F45zNG4vLS0mWXkH+UCMTzsb0MvL/m6QO/k2LZ95v3uBkgidN
 ZYRtPle2IKKQNbLhnZxaDclSZPqzf5jd4gR7nIrlyhwVGoJ+6yRfjLgwHrgU9JT1leBXhOh7OVW
 wNf8kGxuPEr157oPhS+VtfcTX/IOLHBLcrJg1TtCWELRIh+H4rzkItQM6zlBu/znd5sMHBJR3W1
 LxZXHlkmZca9Noi+ToLeCRqSK8xHWg1I+YK/vwW/kLn/zX7ALe4WicPfny1v2gDr+4qFWoNdbYq
 wNaC5S7kQx1Q==
X-Google-Smtp-Source: AGHT+IEyVRjHTyznDTouzAuGOnPk7aXNLk0hZBwvPvgxC1sbf1PCXtLg95uEgrzPeUdjpryQjBLfJA==
X-Received: by 2002:a05:600c:c87:b0:456:f1e:205c with SMTP id
 5b1f17b1804b1-45b5179f338mr202695135e9.4.1756392429682; 
 Thu, 28 Aug 2025 07:47:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7bfb13a0sm24544885e9.9.2025.08.28.07.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 07:47:09 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:47:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <david.marchand@redhat.com>, <dev@dpdk.org>
Subject: Re: [PATCH] dpdk: support quick jump to API definition
Message-ID: <20250828074706.3f1087f8@hermes.local>
In-Reply-To: <20250828024631.30759-1-fengchengwen@huawei.com>
References: <20250828024631.30759-1-fengchengwen@huawei.com>
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

On Thu, 28 Aug 2025 10:46:31 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Currently, the RTE_EXPORT_INTERNAL_SYMBOL, RTE_EXPORT_SYMBOL and
> RTE_EXPORT_EXPERIMENTAL_SYMBOL are placed at the beginning of APIs,
> but don't end with a semicolon. As a result, some IDEs cannot identify
> the APIs and cannot quickly jump to the definition.
> 
> A semicolon is added to the end of above RTE_EXPORT_XXX_SYMBOL in this
> commit.
> 
> And also change the gen-version-map.py to ensure it only identifies
> RTE_EXPORT_XXX_SYMBOL that end with a semicolon.
> 
> Signed

Semicolon after macro will cause scripts like checkpatch to complain?
