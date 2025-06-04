Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6EFC5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 20:46:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 512834026C;
	Wed,  4 Jun 2025 22:46:38 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id 3578D4025D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 22:46:37 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-6f8a87f0c0fso4215856d6.0
 for <dev@dpdk.org>; Wed, 04 Jun 2025 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749069996;
 x=1749674796; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzFrjF7daY4ZjXoWEUmh+qr5J7h6JUEsX5LU9tJoX88=;
 b=XLDUXW3J/0gbb2QxaUSkLS2Bi/B/esx1WyCflR7CJen5nXRjDeQGnxywQB5agVp5Yt
 pvenXlGDrSD3ixuHub5EG7EkP2Y4mGqu31MhJ/CxcxpUwewbq0pVMU8QuCPIG0q9RK44
 oWB9vazMZ3MEQgRjx8eS1HEyoXmW+l2NthV0dO1SBt0dcVrcFEIVp+CHzNSN11pVoDMf
 WyMkmLOyD4woMIyqz3cr3QsdfOFJwFbkhTN+lIrYrgZuMeynJftvdWeeas6voGTHZFAl
 RgfzOkhUg8hdF/6DAZTdgAogb6oox8VFQ39NW+ZXlQQE3g+2HNweGm0XY02yNqBVjkET
 r4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749069996; x=1749674796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzFrjF7daY4ZjXoWEUmh+qr5J7h6JUEsX5LU9tJoX88=;
 b=B33/YyqrGC1h88aAODvP5ATYfBlKKMHM++lOWlbTBhZLMhp6RcfP+RDX+H0qfh/yLI
 LlMg8o5JUgl8IeDnEhdiN1JAgAzFzE4MCPXrCVmZozzHcXJKnJ4YhJXwaZug2OEDpQhe
 rGCSrhUS+4Zt/v7a1YrkYEXCmloeQXHJSClMI0FoIq+WAa8S1qJgvAH8eAQvBPY0dOoD
 DSXu1hNDOKk41UNuOgbmqs6F05Blj/U2rsYszWURkw65NaHcnoFkLd0AhumVZD10TSu9
 wVmJG1r4esyIQEfFIvgtCUEEJz0hh/3z/5znG5zWjNcSoLJxZD0BmJ7VS3zirGsKQ/S2
 wvPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkUUk829udCC1X3EiVLa/MHq7wEGgtZsLrsFwznd4TseeqSczd8OYBC0OIiRRpYY+sRnA=@dpdk.org
X-Gm-Message-State: AOJu0YxWwds3hVQ5Snn9SyE6vvklUxdrWffhk88RluEemnBMm3b6/H9R
 opNSxFjIoTg/UjI7Y0O8+Bg6vMcUMOT5RZPdbecy/JVzOILl7h+OqHaCOMBryJ5ygeY=
X-Gm-Gg: ASbGncte/+1YLGOYYS3aHSEJskllRiiNTHrweLuvJBFksBL+i+pk8UAE68fHinkLO3d
 SDK13RKMqAne80ZdvudenoUK1hP9foLy12T9Ay3RH52hzEQ7A1g18d1R0aN7TETEZlb6K+bj+aX
 lEgnb5XzIxzEzYXaJJKJsVTCu0ZfVqn3j8tEUb66GNyDpwZfAtc36zolMqWatDa0zpZyY8h8nF2
 hrZn+v1tjq9eNUaajU5vYsYXrDCKJc7en2Xh71kjTEJX1WlSqU+JCyuPFapspvvGxu8cPgCixSD
 353k027EPiwQamGycj3S3Z5K3L+1milwLdAcTyEnefJhsMVMkgQdV5BRm/zfIc5bUsYKkvijU5a
 gsmU9Ub/lmdr9b47buY1n+o6JCdLu
X-Google-Smtp-Source: AGHT+IHZu2A9RTjzU3sRUYkW8ITLFMEWgtCXTWLcGjNfcAOzxk+yImRembHWh7ZHU/keFrduEI2MCQ==
X-Received: by 2002:ad4:5dec:0:b0:6fa:9baa:face with SMTP id
 6a1803df08f44-6faf6fc3deamr64701516d6.35.1749069996316; 
 Wed, 04 Jun 2025 13:46:36 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d09a1a793esm1099435485a.111.2025.06.04.13.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 13:46:36 -0700 (PDT)
Date: Wed, 4 Jun 2025 13:41:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <kirankumark@marvell.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, <dev@dpdk.org>
Subject: Re: [PATCH v9 2/2] drivers: add support for IB_BTH header for RSS
 in cnxk device
Message-ID: <20250604134124.3979a78a@hermes.local>
In-Reply-To: <20250529154343.1589903-2-kirankumark@marvell.com>
References: <20250529153908.1571050-1-kirankumark@marvell.com>
 <20250529154343.1589903-1-kirankumark@marvell.com>
 <20250529154343.1589903-2-kirankumark@marvell.com>
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

On Thu, 29 May 2025 21:13:43 +0530
<kirankumark@marvell.com> wrote:

> From: Kiran Kumar K <kirankumark@marvell.com>
> 
> Adding support for IB_BTH header for RSS in cnxk device.
> 
> Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
> ---

Applied with some rewording of commit header to make check-git-log happy
and whitespace change to the header file so new field matches others.
