Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2B8C5B572
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Aug 2026 03:28:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9587B4021F;
	Sun, 16 Aug 2026 05:28:48 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 7EE9740144
 for <dev@dpdk.org>; Sun, 16 Aug 2026 05:28:47 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso2361788a91.3
 for <dev@dpdk.org>; Sat, 15 Aug 2026 20:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786850926;
 x=1787455726; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZQm8ywWOU5nwFAY5V45QLt5zWPDmc0BsPHBPfvTbLm8=;
 b=qsfubBIrKe0wJc7gu0vqvBgFZBsKvh5Co/Xg4dP5yApRKhE7bPbTnGQsJ+CjJo/4pT
 r8oKmqfwGeTIlQhyJUEeAYKezhePn+rb2WGhDI8CPOOz7tvTPjTiSqmdTGSk7UhjTBaG
 jq0JgbDPsgUeG3DkWJkbNQN+37/neZNmGlgbYbZtT26mwrxh1Ot/mLPYgVnafvS3clZb
 wiVkDsPltgKY9qipfIZ2liSruDm6hzZ9rCZch9x4zBE7rrhj7WFocoyAUwN3/2juDtB4
 U+qvZ1bo1Xa5ug8GQswtHpnpEV9vnPo6E4pwlEontngKNJHClC7tjfV47I2kbNi3uVeP
 0PIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786850926; x=1787455726;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZQm8ywWOU5nwFAY5V45QLt5zWPDmc0BsPHBPfvTbLm8=;
 b=pmpGoWabKyUeg7mn2zDewIGVDTzip9YbAbVGXvJDPmhuB8aM74dVksHIvGnPNDX70i
 iB+ziH+bLnCEBYDFYI5zBKecVwOleyJs6NNVRXzg6qhfTDQxcnHgOff47oDoVqX2DAiY
 NL8aUGGr+BqA/7aZsGJnQNzRujU+XLHrj5GgxBqnfES/o4EcT7sOEY6xWp8yo19REBoy
 DQNhDS142IoJWxYOxbUKH7JLP6cDQ/3mJES5bJ/ZY75+1uJbZQDa3mRs9jGDvMtXduec
 JiJM45zlxcxNoWVLj6iUFkMMNkxnc4IvWDctWo9IAycSA64PYzaaoaG544CwawVRn7Hj
 erVQ==
X-Gm-Message-State: AOJu0YwiLxMTsNKhCF5YgCW6Hc10mzXzRTM/yXXorwQlUIkna6ffG4oE
 oos6HU/5/KnhjEB9D2Hm1VrMpypn9HYNHPyFOOore7488aL9DqJRMIIpBe5xLyXx/yo=
X-Gm-Gg: AR+sD13RuWAlmZf+H3eh50nwuGpT/fgEj0dBN66CRZnS083MSnuPCBMbrnnqIhRbWx2
 Q1vlLJaE0Tnd3o6dtrZyPCZphbVEVHmuoMcwldeiJvPybuTKHGeAE0Ejcv8wQcrkM13WAcoUjQl
 wNGyQThi1p2zBevRhxBMpfXx3ixARhRg/rYxWDSkcKx4E9qGjybD332Njp+eGWbWNDw0ym+HdhH
 t20afI9hIr0o5rhD7bxBIiS/oUloA+9GIyIg/EForG4GCzsHjNAJT0t5POMZR0Y96o0rCLlsGIg
 HvHs/TMRv+kVXZTGgXGa1jZE0+Z5PAdq+OJmnICgVjcBW6FkAhdIVACFI0ww7XzeeJqE/d1ODJ6
 P4btTnuhK/N7Yvt7hsbsuOf+kn5HMU7VvYiZ96+NVLwCVA7N/Hq5haJ4waVIzD/5KbJA4q/358B
 EdK5xMzA3mBR9Xug5NW+892IhMIpp+B3MGMscFgOX4tqdkpS9ceRruA/2jaoMM1kiskLOn2Oefm
 kyuryO5k+GMML/jkiDuPFHRttUNHw==
X-Received: by 2002:a17:90b:5101:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-3933b6d0deamr20557659a91.1.1786850926527; 
 Sat, 15 Aug 2026 20:28:46 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141387c56aesm24413894c88.4.2026.08.15.20.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 20:28:46 -0700 (PDT)
Date: Sat, 15 Aug 2026 20:28:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andy Moreton <andy.moreton@amd.com>, Viacheslav
 Galaktionov <viacheslav.galaktionov@arknetworks.am>, Roman Zhukov
 <Roman.Zhukov@arknetworks.am>, Pieter Jansen van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2 0/3] common/sfc_efx/base: add VADAPTER statistics for
 Medford4
Message-ID: <20260815202837.4600ab12@phoenix.local>
In-Reply-To: <20260812171039.8538-1-ivan.malov@arknetworks.am>
References: <20260811174949.8993-1-ivan.malov@arknetworks.am>
 <20260812171039.8538-1-ivan.malov@arknetworks.am>
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

On Wed, 12 Aug 2026 21:10:36 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> This series adds support for per-VF (VADAPTER) MAC
> statistics on Medford4 in the libefx base layer.
> 
> The first patch selectively updates the MCDI headers, adding
> new definitions needed by the subsequent patches.
> 
> The second patch introduces netport VADAPTER statistics IDs,
> which identify the per-VF counter set returned by the NIC.
> 
> The third patch switches the netport statistics call to use
> GET_NETPORT_STATISTICS_V2, passing the EVB port handle so
> that the correct per-VF counters are retrieved.


This part is fine. Applied to next-net
