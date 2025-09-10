Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC209CA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 16:42:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF3D64065A;
	Wed, 10 Sep 2025 18:42:27 +0200 (CEST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id CB871402C2
 for <dev@dpdk.org>; Wed, 10 Sep 2025 18:42:26 +0200 (CEST)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b0473327e70so1163511866b.3
 for <dev@dpdk.org>; Wed, 10 Sep 2025 09:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757522546;
 x=1758127346; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D2qdxwW15aZ4a2N90Y6exYaog0X+DxnRl2qvBrObFZE=;
 b=vy9mIsop28ez1pqTXv2FrNSmYbOPgkMxvfGEepFDRmYFhrXIZkH5F9mbqu09dRGBdZ
 TOHb6xyHBeRpVzWj6aOwzkIX+5V9y6zmoPYYHm3mXP4fyXInJUgP3MrLQDuEDqecCOlo
 O9aP49LbUo/BEgKPNjBlLtAJXELkR7YKTT5gB/bHYmYv/9pRj66+J8bynEAFj9SzP1RF
 OiQdcTLeGskGc4kgqeRsg8iTf6ntAy+kMYPYUASIgJGScuikf13ZSbmTjFWz8r/7UTjH
 VTa2YXVc57wOFStAg5JwamNOfOCAQEPsEGT+TRBB5BWnE3Qkx6nmWLsAaiqDdMrl4zhQ
 vNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757522546; x=1758127346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D2qdxwW15aZ4a2N90Y6exYaog0X+DxnRl2qvBrObFZE=;
 b=Vaa4Ys09VJj263iuA8SslAz7wHzK2H02sEYYiPUnwsQKVBTf2kHZLPOnl8I7LwB1DT
 QSZfyP8ROekMA9Dre2iFxdaCu/PzDpbV2jDs0Pht+JmVYG85G2/V5zGMbxXp9AGtMwC2
 MqKjFavzMbrIeeQykjP4k/Gdi5f80QH6gY8G+1MwuKS3Cvmhpc+BLz/H2BvZJLZj8cTx
 7t5A0EDixFJyS/mkZY3B3fpk4YqMsq2q4jd+rbq4KEtHcG3j57eacMxsqSTyfJ468DUO
 D15PrBLNlA5pJTpelxFh4hhR0FqnZtfh93xOGNsKO+RRVAIE7UeCX2umj/yr9UrtVqaR
 onUw==
X-Gm-Message-State: AOJu0YzQB51oktkLdI7Vb7ipFmvOvY4ais5Q4hb7sxriGigd0Oc0Punt
 ePEvHFtxX9wq7IOpFxuLeLbBccIJDhTOK2hou/z8D6MJrTaVxi8qS1X+CLUvBfMVNFI=
X-Gm-Gg: ASbGncsnMBIeTlZDTiFT1y0PscRYh0LdkY8/FSXFCtt9Uc0aOIAcEU7xbxYcl/ZXzsu
 MxW2roHD+D6cG+8EfSjsDEWiKOP3uSBdziCTAc7BYIcpiv8DkW6YsM+kvluzX+dYPo3n2OXffBM
 4NTUGMhka9mEemVQwAzxAnECpHpxQ49IqHvq9ulUSfVZXpoIoBrb/iSkOfrhs4pviK4dP8RHgmV
 ByTNm9ZpUyJlhehn8NwJwxlK2tMeOji1GvDraojPNicfGv7zcjpCGlVk7bzffOGAcbdX3RV3S0v
 xaWHKkRLg9is2PBOH+uv00u8KYLduhedB/YcZILuLyPDO11C5+Kv/ZJ9jT4cIa1lyRXv0UTg1o6
 7TxjT1zeG8AJQuzJSFqlWw56gBxKG5c1GKbnJnobOkVW/+nXGkctxsQAjndWlU9EAFy+/7xHT+A
 E=
X-Google-Smtp-Source: AGHT+IGNpBBY/7DTiwHFRO/GQUn9PpjF7H86b4QGeF3YyJTD+pDto092GK0I7sMs8ZHFBh6DuC3Dqg==
X-Received: by 2002:a17:907:d0b:b0:b04:57f3:ac9a with SMTP id
 a640c23a62f3a-b04b173d474mr1435858066b.64.1757522546345; 
 Wed, 10 Sep 2025 09:42:26 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07833ffc38sm188938666b.92.2025.09.10.09.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 09:42:26 -0700 (PDT)
Date: Wed, 10 Sep 2025 09:06:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xingui Yang <yangxingui@huawei.com>
Cc: <dev@dpdk.org>, <chenbox@nvidia.com>, <nipun.gupta@amd.com>,
 <huangdengdui@huawei.com>
Subject: Re: [PATCH] bus/pci: print the return value when probe failed
Message-ID: <20250910090626.49a1d960@hermes.local>
In-Reply-To: <20250828030027.1865866-1-yangxingui@huawei.com>
References: <20250828030027.1865866-1-yangxingui@huawei.com>
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

On Thu, 28 Aug 2025 11:00:27 +0800
Xingui Yang <yangxingui@huawei.com> wrote:

> The return value is not printed when probe failed, and it is not
> convenient for locating the problem, so add it.
> 
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---

It looks like there is a log message before each return of error
in the probe path. If not maybe add one there or change the DEBUG
message to higher level.
