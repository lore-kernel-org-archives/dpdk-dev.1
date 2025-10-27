Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DD6CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 15:25:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D438B4028B;
	Mon, 27 Oct 2025 16:25:44 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 2E1BF4026F
 for <dev@dpdk.org>; Mon, 27 Oct 2025 16:25:43 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-33bbeec2ed7so4419958a91.1
 for <dev@dpdk.org>; Mon, 27 Oct 2025 08:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761578742;
 x=1762183542; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2c3saMC20P+hp1MlmRJV9kzZwbXrw13nPxMIufharXA=;
 b=bf3jEaiktUTkrrAuFIROjF1CcmsSFx3aN/3WZ8wu89nwOtjP+jbXQTrXxD8beKVqUz
 NnU00jyfOx+e2wSJmD7olGNx1tNkCdsyytXeamuBMdqmx0V/1+aTCVJS8/KDx51BkehZ
 A2eJeU70kSbtsDs18nyT+hOHBmEJpnRUp8z+IyeBatOf+OeIiPY6sRlg/WI0ydkzTmZ7
 Sd11aaJ3YXit1lzhtS/gKi5sTkI/e9UxYio67qXZTkqlfUk+gLpbtyLEV95faBc0O75P
 Yxlb0pJWeUyImCs4tJCR1oMR6vIYjHgVasWQFqXJYyatbEMrAIen4ti8NqI2xmUZQFvC
 PoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761578742; x=1762183542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2c3saMC20P+hp1MlmRJV9kzZwbXrw13nPxMIufharXA=;
 b=Cnb9tzkVxGjHy3O9gXVmMJREReb6BWryb192cMASjONEETqeJuSCBinv4muYx60Km/
 w1zznJJyYHyQNYhXXo4K/yi/mn8KACQR2mbkVqZB/khIeuiS4LBOEO0DHp5U0r3ezUye
 t44aEippVZdmmbU8NYMP1RtXI/ACSBbj6YtUSrtekli6B5BOsNNSNSY8Z3UJNFPL/4dn
 3f9K94NE3RnYCjqz+DrD6IPYYWvMLgZIb43C9ndc395CdBgic48rINYBMgEu7Z7sSaGD
 BpHYqHPhfI8zos76J/vfHgj/w+VHJZw5xmgRi+/W6Os9nSFAXaCnATymmGqceTncN/DA
 t+rA==
X-Gm-Message-State: AOJu0YyWdoX03f21h4MEBOR3mf/L441N3ajTYeLu1bsKy5JFSZss3ED5
 AGlHEq95TjDNlJa4bDM40D4e8duzuV5+9XGh7dgkluzuUPuPFgHQGO902hZx6Zx/xTjR4JSL+sc
 11NfGbGA=
X-Gm-Gg: ASbGnctSkhvguJY3jF8Vry5FR1AEp1GalSUbiRGqxTUCJFqBiCSH259WrFn9B2qJU23
 VDRGZsAbLTGjX/chxdxSmhHCfhuVFQEMT/NVTtWBPqh0l+T7GPVo9K6zw+NrycC+6GyR+0qx7KV
 9aX+F3ZyhevfwhXa9t3y4g00ycsM/dJMBlER5pmHMSr53fp0M+76GUHoDuk0vONOR+fLZPm9OQO
 pyyDEdNj+YRlbDhRs4FTZIjBKKTeoBp6C/iCW2IM3N1pX7m62YkPYUJp+eCN4RE9bp7meJNuvSG
 oGjVbA83ia7Hg4d9PSCdV09m7RzGmJJ+oezDfcR0KNNjCjhN2mOUeOoKU+ErZrXGDfDkuIaqTUc
 5pbeLFWWfxrqgQkN0JQaOvbQRzPXNTJieKwJNKN0OJLX4pzQZLkQu5orsKaw9CLFJHwH1YuLcF1
 jRYAMPuyaqLaXoLV7oXMF0jKqiccJWvwsECEwICa0BNyo9
X-Google-Smtp-Source: AGHT+IHNjTAqnMQk++sQPsN1PifMm74P+RGRyeD6PqORyHUE9qC0jCLdSh1d30/b0IKOJPj8NNcGkA==
X-Received: by 2002:a17:90b:134e:b0:336:b563:993f with SMTP id
 98e67ed59e1d1-34027c07773mr128962a91.34.1761578741801; 
 Mon, 27 Oct 2025 08:25:41 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a41403fa75sm8517281b3a.28.2025.10.27.08.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 08:25:41 -0700 (PDT)
Date: Mon, 27 Oct 2025 08:25:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: david.marchand@redhat.com
Subject: Re: [PATCH] devtools: fix awk regular expression
Message-ID: <20251027082539.7f9f359b@phoenix>
In-Reply-To: <20251019160511.18173-1-stephen@networkplumber.org>
References: <20251019160511.18173-1-stephen@networkplumber.org>
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

On Sun, 19 Oct 2025 09:05:11 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The latest version of awk (in Debian testing) will give a warning
> about invalid regular expression error.
> 
> 	awk: line 6: regular expression compile failed (syntax error ^* or ^+)
> 	^+++ b/
> 
> Fix by using additional backslash escape.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  devtools/checkpatches.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Looks like upstream reverted this new warning. Patch is not needed.
