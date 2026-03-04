Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74450EF8FE1
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 13:18:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73321402A9;
	Wed,  4 Mar 2026 14:18:02 +0100 (CET)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id BDA7F4003C
 for <dev@dpdk.org>; Wed,  4 Mar 2026 14:18:00 +0100 (CET)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-89a00e8dc04so28942656d6.0
 for <dev@dpdk.org>; Wed, 04 Mar 2026 05:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mauricegreenjr.com; s=google; t=1772630280; x=1773235080; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cb612FMRYF5NoKDs6sJiCqOurpqbyICU0qyIIvrnq2o=;
 b=s9b4ibXohkQdKTw0azbQ6iCm1NjbH2TKG+eeqNqdaY72aR+ZkYEIBFp74LasjL0Bfp
 4nLbDJohDGNl11I/5J8Bem7jk3rFnWCNfS8JeUnLGlV6T9cecyD3cwRL6qA5FPI8Vlpd
 bEXCfjLQW/HQJftCcOJsEPgN/Tvq0ZaoJvjPf6+zyTLwdlcahyjkEaOkQXJzRD44PsS4
 UHEodW2m48fmhjAPk6EIDz1jL6srcMy0S5pPC/+NHD+Gkws6b5GW2qvlFhe7N5mk/7Mf
 MjBz6vRU1sDxf0IiKR4JxuVw+jpljTKp6WPA8DuIwAMWTpk0apNMdH4bD3frYc+L/ps3
 zygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772630280; x=1773235080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cb612FMRYF5NoKDs6sJiCqOurpqbyICU0qyIIvrnq2o=;
 b=J8axvk0ir7rvziTjtATKYn7FzzLflSoexKTZgF2mv2BYE+dQ820PhL6Q9pA+CkU3H8
 zWBPXaGErNCS7qgI8l8TgOf0OPluAHzKmevrU0fhVWxivBMSIB7E85dnXAUJUAKHi3l8
 Mamtn0W6XL9RkcTdzjr+VQheaUFab+a4lRgYoc3cwdWOOmr6SGHLIpV2NOz1yVYWP6bR
 iX1Bx2wPtO5tzMLZ7TPdgmF0H0Xn4iAX1JSocNxU9S2dfUM57xR8C0YKWGmhgI8GIMxP
 37EECxhCyUX4pL8SEny6wKDcoMKLstk69m5cyEpj2qj2V5Ux0JzukfiaQX7RR44qtA+S
 whiA==
X-Gm-Message-State: AOJu0Yz9U4BQh3PmjDhtbXWZEqGdZ0/eImMnwCV55C6Mc39KWWyNb0Hf
 r6xn/cdXGsaJL4ju29lLpU2hhMbcNC5qb6/fpn0qZao3dWosiP61i9NJkDHQcSZifJI=
X-Gm-Gg: ATEYQzwhMWRdyADJjTgyCoOP8E+G6Vj8LtK0K+2WlEXWwFpy15d6PQJVZyK5crbJ2Ju
 seX8uDjln5PR9XIiKXCZceUqYl/RLV8/K7iCp6xoZbev2Pbq9nQMI9O1gRH440Vdl3NOj7gtW2O
 ncJA2GHXZ9JQi4jA9V2COE39P/95azk5Hx7hvvdyj8m5w9Eh1D6V/v8UhvO2PMhHsAnoqPsj42f
 Cms2wPFntWkimavA/wwGeAJDRcbYLG2XtXeVCXlhUKzQFk8TyN3K89mB9lzlBEh6utn7ciAelT4
 rJr1486El8/GyjIR1Q6xPen0DW+kzKwr5Us0rMW9JUg9AYNLKZKkzxZfSDQ2BefSpLDneSGx1Bd
 mLvOs0WNFTWSv3DwSCs2btrQhJTerPOHnYnH9dW/z42EE95gCT0n74TLZKjjDxEdBGwPxsHVTYg
 3W6/H06BvmebtfIOqEYQKS4wBVrO8IIruBQ+8HLwJdnmljSe9Q116MAVDI+D5I5lzVUo2qxotif
 u3j
X-Received: by 2002:ac8:7c44:0:b0:501:3df2:fd60 with SMTP id
 d75a77b69052e-508db2a4b2emr22715921cf.12.1772630279984; 
 Wed, 04 Mar 2026 05:17:59 -0800 (PST)
Received: from localhost.localdomain ([2601:152:281:a9e0:2164:d51c:5b80:c83f])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf732bc1sm1627244485a.46.2026.03.04.05.17.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Mar 2026 05:17:59 -0800 (PST)
From: Maurice Green <maurice.green@mauricegreenjr.com>
To: getelson@nvidia.com
Cc: dev@dpdk.org, eagostini@nvidia.com, mkashani@nvidia.com,
 rasland@nvidia.com, Maurice Green <maurice.green@mauricegreenjr.com>
Subject: Re: [PATCH 6/9] gpu/cuda: more gpu ID for h100 and l40
Date: Wed,  4 Mar 2026 08:17:54 -0500
Message-ID: <20260304131754.12096-1-maurice.green@mauricegreenjr.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20250915144137.54858-6-getelson@nvidia.com>
References: <20250915144137.54858-6-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Tested-by: Maurice Green <maurice.green@mauricegreenjr.com>

Tested with H100 (device ID 0x2331). Confirmed GPU detection and
memory allocation. Still building my program, but no issues so far.
Happy to help test further to get these patches approved.
