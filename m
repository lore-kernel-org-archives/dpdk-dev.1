Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E64AD6CFC6
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 05:17:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8D37402AF;
	Fri, 23 Jan 2026 06:17:17 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 218664021F
 for <dev@dpdk.org>; Fri, 23 Jan 2026 06:17:17 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso13732985e9.1
 for <dev@dpdk.org>; Thu, 22 Jan 2026 21:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769145437;
 x=1769750237; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNc3XeBLxhLQTXY97C9JgCY0jIncWcJ15C5H312BbbQ=;
 b=giL8VXKA92JQ3ON65CwTSgMs2BO519f7iCR+tEPLTF57kbRl/WwN7/uwSTuNDfdZqH
 2TF0R2lp45CsqPjfoxGbYmtCBTdDRXy/S4dSGidZuUp2apebaRBRI8dfAg9U6iSCnmaH
 56wCnIVHN582kbXPRJj9KOadPIWGj1F8+3k6SPVgAWT7T7QR0wFc2o7cvSDBdZlqKKqZ
 olMq6bVfyoG6/EF8XWkH3Z+g9ZvMObQSjkfQ3T+za2SzLNVUbYBlyjFXQ265e5liuDKE
 SkV/qJZzJ+dRXua5XJtAraM2uLX6/rGASu/o+HSLYHv2P+0UzRztVPXHprRmOCtLd+3T
 ZqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769145437; x=1769750237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aNc3XeBLxhLQTXY97C9JgCY0jIncWcJ15C5H312BbbQ=;
 b=SLbfbCqSv2PN7CDxG/ou3503xSsxUWDaltZiX8eoM7i+eSWAcYHT0Jq9uhfybNCP8l
 6g9zhf1qoNGs83CiHbck33UMH0+wabXF29sUDQhMY+yWSmhxeWJqdMuLMWrm9bNVFkbO
 O5T984pW1XgKh9jwqQAHdQ7CY/C56AtLGRYS0E6WHTGgrV7mEPk2+BhTnTebIEKjgWCe
 Mt+BfAPozHY9A/fhM7cvH6LoVA4Aqa3MkyC//sL/6fgKS/Kt9CEy3/Hu/+WI0/ZRSAs4
 mvhTyENGJNuN3jXkGKw2oYfaA7B0v97LUFWNZPiuZol0Jdq8l1iGbQb4On6sEbkF0y4x
 sIbw==
X-Gm-Message-State: AOJu0YyFCv2NThLicCsZz8rpPoJXlF+yV3Ec5jaVcJVRw3qDoJGx1q+a
 S89jpWWUW4AacHywy0B3wPUo2EdB3yV2TQNdhDMknwj84ANixBZfFGaJ+Cg+z+Tgieo=
X-Gm-Gg: AZuq6aKH4g0+x8dJmnuZLwugT4XOMggYa+tUBBcwsgp6X4MYeC2nukTQCasUua8STJ7
 eYS+3ZnkDmik6SK1zjB31sWvROZSpzZESLYMbEMmXaZ+naV5vdOZkyMRwt5k5CCNJPMbbm06ZC2
 n/12d1MkybexGz4B4LF//NlueyT59QQWTzjNmm9uJR06rxHJvNdKZisYYASGhTuJAbi4VaMMXu1
 1+5XSCDopsYqnZfuIGhgzNBIzB2Tl0c4D3Ldh9Y5XiJTq/i6+ESP62A+ak2vgcwUn7KlhZ33WCA
 DANN1+FXeQBYh67wHxevP5b/kKslsCC6FSS1iCi26bhE1qfOrNiTu9FUKqCtYG7FBc/7y/gXCbq
 3NThNiAj1f1hoSRNFPYrNj89lCljZOK1GTseKNvaoIejQw/mwN/tB5Y9de9gnvxx32OmWNrxDTQ
 wMAUc+C3WdpWrYLYBEZU8Jea0LsBCPbAQrezfV/H1uaAzk3gZxvq2d
X-Received: by 2002:a05:600c:c16b:b0:477:a978:3a7b with SMTP id
 5b1f17b1804b1-4804c9b2113mr29545535e9.22.1769145436569; 
 Thu, 22 Jan 2026 21:17:16 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48047028928sm165680825e9.2.2026.01.22.21.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 21:17:15 -0800 (PST)
Date: Thu, 22 Jan 2026 21:17:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <mattias.ronnblom@ericsson.com>
Cc: <dev@dpdk.org>, Mattias =?UTF-8?B?UsO2bm5ibG9t?=
 <hofors@lysator.liu.se>, "David Marchand" <david.marchand@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>
Subject: Re: [PATCH 3/3] bitset: promote API stable
Message-ID: <20260122211711.44710c70@phoenix.local>
In-Reply-To: <20250518080556.675092-3-mattias.ronnblom@ericsson.com>
References: <20250518080556.675092-1-mattias.ronnblom@ericsson.com>
 <20250518080556.675092-3-mattias.ronnblom@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Sun, 18 May 2025 10:05:56 +0200
Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com> wrote:

> Remove experimental tag on the bitset API.
>=20
> Signed-off-by: Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com>
> ---

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

AI review raised the question of whether change out of experimental needs
a release note, IMHO not.

Perhaps a script to change all the experimental API's from 24.11 or earlier
to stable (except tracing?) would be good idea.
