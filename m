Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78B1C36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 18:24:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E3E6402F0;
	Mon,  7 Apr 2025 20:24:01 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id 21182400D7
 for <dev@dpdk.org>; Mon,  7 Apr 2025 20:24:01 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-6e8f6970326so45594066d6.0
 for <dev@dpdk.org>; Mon, 07 Apr 2025 11:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744050240;
 x=1744655040; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZtpxMS3RuJmTgSD6rqLmuHdjYFxeugp6zF5SWbq+T0=;
 b=YkNeSMHDh6+QY7r+KahtLS8U1rGqg29XRl20ZPh7fBHXWNLjqLz1mf/QXnByOTVQ1K
 /0MYo2iIbANan6bQda1gSn7peDNIo13K6IgN1sRRB1tqz4mqrFkTEm1n1EWkFvl2wMtX
 tCgb+Bo8tOpcIk20q/Uh95HzJcsdXBAbUqUonJB7bYn3ptS3hD0u+i1+bdBlTQ4TqtM/
 tbZO+5VeKJ0SVkMadO/AVPRgIjKtA1XDzADRYP2mIZ/YjClD3Yj0knPT6a21bAR6Vuiu
 IW9nkmQTostu3krE0aSfk9KP2BcgmdqmhzOZnOhMDLa++qxthMRGFbmjfAHaxl5k1Fxt
 2Pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744050240; x=1744655040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZtpxMS3RuJmTgSD6rqLmuHdjYFxeugp6zF5SWbq+T0=;
 b=NOxyOjRo+J4Hpe5rn/nYjhKWVXQZqB211snaFHZs20pnwOYZGpgv4DEJsLTmTOX3Ll
 ETz8BeM/Staw9TTp6O/66BhbGpqXz83W0ZD5y/TMrF5HMEuLcsnxinG4TKOAo8sAvy7v
 f20zDP6aBO0Wz8K41p1FBCt1BtRzNVnlN3L7LXEfPW/VcL1fO+a+8xGtZsL3LouLnAEL
 ex5prI/m16m34h4LRikxt3+Da7WexrZQriLBW0FlWUF2S+mNg+xuFp4XNput72fd7VBz
 lIo7y6sWcwzzsKapi1nh4nneiGGX1dR3/3yOFTLs8eS5KiWsik+cRVErQQXQuCNoS6Ij
 6HJQ==
X-Gm-Message-State: AOJu0YyVRwRr50ascCBbedgAYd3C/Z8O2FJH8vBqWg/+KDoie1LatGBS
 RoG2QrN57eIvyg7/Qy0KrmEuzQ6iW3eL86oE6DgDGeY4zecvEnPAEr4RDq5D/CTNES8Z7c+lGrK
 Qrbo=
X-Gm-Gg: ASbGncuIeSpTuZlFsozyp8RvICQtA7y9Q6WSYLDxB6vPNtbMpbubNOcmcHQx/91dWSK
 IZzpWYbNEXD9f27ZwHaUcVmnVZ+19V7P4B9jdXZUZfPlfRKVpEgGi3u7devQB3yW0xfPMV2jgmK
 0V7GLXys7iOGXx8+HXv9iH+uzjm3L6bJVSVuj+cWUYigqNqegrwt2+K5tqPaCgq9R0yeH+UsCXL
 XZF2WKL4PcLxZkWIWag+zJvaQOAkn6TQOUudYZW6dBC2RgywK1/O5l77lUI3geM//TttcZhQM9f
 NgJBQ0+OgHOwXGL1ZtD2NmZ2e+mzqoeKupgtB3Tv5CoTd6ZoJMEtCOls03jbTujwQJUWzs2XYZg
 J6vx3w7eDT7F6o1ub5jaZ
X-Google-Smtp-Source: AGHT+IFMklNMgsRncZFkBNAOs6cml7pTTS2bf4JwtSZPyHGOA8QyjHDCfePgieiE7aT0UXap1qsdDQ==
X-Received: by 2002:ad4:5b88:0:b0:6e8:97d2:9999 with SMTP id
 6a1803df08f44-6f0b74a74aamr127195126d6.28.1744050240320; 
 Mon, 07 Apr 2025 11:24:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ef0f047e11sm61800036d6.60.2025.04.07.11.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 11:24:00 -0700 (PDT)
Date: Mon, 7 Apr 2025 11:23:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liwencheng <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 4/4] net/macb: add necessary docs and update related
 files
Message-ID: <20250407112355.3140146e@hermes.local>
In-Reply-To: <1744008035-4906-1-git-send-email-liwencheng@phytium.com.cn>
References: <1743577871-120091-1-git-send-email-liwencheng@phytium.com.cn>
 <1744008035-4906-1-git-send-email-liwencheng@phytium.com.cn>
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

On Mon,  7 Apr 2025 06:40:35 +0000
liwencheng <liwencheng@phytium.com.cn> wrote:

> Added missing documentation in doc/guides/nics,
> mailmap entry, and updated MAINTAINERS file.
> 
> v5:
> * Add driver based on 25.07.
> 
> Signed-off-by: liwencheng <liwencheng@phytium.com.cn>

There are multiple build failures reported in the CI system
