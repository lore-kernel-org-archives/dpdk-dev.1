Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14249D35687
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 07:06:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9442402C4;
	Wed, 28 Jan 2026 08:06:07 +0100 (CET)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com
 [209.85.222.42]) by mails.dpdk.org (Postfix) with ESMTP id 40A20402C1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 08:06:06 +0100 (CET)
Received: by mail-ua1-f42.google.com with SMTP id
 a1e0cc1a2514c-93f5761e09aso4274555241.1
 for <dev@dpdk.org>; Tue, 27 Jan 2026 23:06:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769583965; cv=none;
 d=google.com; s=arc-20240605;
 b=ZYAQhKM/VeGI956ud2TsoVN9NFaDYKNbA1B2HLnfAMSBNgH3woqqw1GfkQ5BS7z3pa
 oTQU0Z8lA4UhsLZ0sPLSlArXCY2cvktEMXTOS5jWygWMhMIOn6MtLeZ3Mv94sZfVh3Vu
 QVLy/EwDANVaf4MzkAXPN/awtZ9goWNFyiQzwqOQe0VeEZ0709imiBkFkw23p32/QB10
 Qn0rB9LLek8USymmQ4wCxaH+EMDZ9YRivVJ1fgk4CbYB2PMTWqKUaKfS6ANMKqeTWbWV
 ue4nT4if+db7bKEzoQ2ByKrsagp47vHQScOsF9mgSKyoH3uxRfXPEf3ghIVwYA+xFiib
 qZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/6gQFTObnRuHb4RrV4wSUuTYqg2nlfbuOhHG2tttk+M=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=VtROmxpD1GlDpfbfdqM3jtfcdUnI1fQX7f14k5sIVcTdY0RdfHMz+l6xLL2unvbAvx
 93L87/gwFGltety6zKs3ufVkbO6MYeCT1NCaUOQqdc1tZ1hZKvJMkPasVPBio7vFxvuI
 rgD73pfe8HGfXfRdc9KgiBnff0H7ELM3kxM/ah8yvFK4xyU9jvESNSF4WfYoj/FKN2Uu
 /5Z7Vbu7He2RrDJwcS+Au+0t3cbX0kWQsf6uS8pgaMJASyuCyRJrcNSZrLfBgdwiw1gQ
 cJbe7dZRcWO42M8H5xDskWRjZObcOw58IBev2l24TuEImgiFbeElmC1pvxV0QBR+H4uH
 3jpg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769583965; x=1770188765; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/6gQFTObnRuHb4RrV4wSUuTYqg2nlfbuOhHG2tttk+M=;
 b=D/1+BHcjFDOWTtZQ66mCQfpk1U09O2WPUcLgJ89a8YgJLEB1RHDf5ocjvC3GhvM9Ob
 omg1I6asjgSIaqjxUwF2+kQ0N0IwcMKKlHLwAlzUMB4dyg/keZvkPCwP1HJuEUfKl0q6
 /RlAxkefxE7fxP9FWQN/iY+D+1iX6U9GP3CSmX4OB4M1Jk/0imOf9cG/0oZMZYzls+uC
 +E9gH21C11/AH4hu/YnUI58V6+umyg7FGKmgj8QcFdStWl4wHZSkX0Q1EBGqWGg6lpxd
 CE98/5Tn/Bfp2SwlG8B8VKRg9Xl1dmo+XQap6zAvrokXtbGbdVg+ozHJ5+snH94u9QAh
 8Djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769583965; x=1770188765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6gQFTObnRuHb4RrV4wSUuTYqg2nlfbuOhHG2tttk+M=;
 b=rw4HXwcXHSVVcPKjsDTAjke33DfCnbd1DUwqTqK5gOB9aRm30VaIm9R3GBBMR9S4ZA
 kBQClnxc0E496cjGoq8x9BtF1UijEqh6Ja+UbCgq9D147/D6nJ9HEjtuk9V0I0aMe5qy
 GcsHJEMmYwPVJkNkpmKJN/tkaqvRd2b0JwciS5pd4AXuq2Re0sTz1nPBcrMFsVE2FwiP
 ML06KGjJK31Zqikh8Oo/imaeoA2bMru6op1+Bt0ERBvAWUa+eNVrapGDBj+oJljeSDtW
 QkyAfLr2Vy++pZ1dmHUhnoVyjEn5TBLf8dEI+9tEm92BldbAZJOFz9YgmhxqcmkggyTd
 uNqw==
X-Gm-Message-State: AOJu0YyBzimSPKOrQqRtk71TCKLoUiiL+zKWRzf+6grgFszfImThdBKO
 pW3nkBauO01T30+G2ybJSPCLi5LqpfCUxRmkVhRax/u7GowXaG11utPqLpymy0QclMVGCTmoWOv
 oGhswjYJNz7d8VOME0DrroFVRw4+4EqEi4+ym
X-Gm-Gg: AZuq6aKVGZnbTxWfHZo7WT+1yA0MKZOoA7entSPQbs5MVmpMUFFH4lW4rF3luzuRk36
 8eJ5ii7HgNYBYLnsEdOuYrsAfGUzqt3yjImlWHiUgdfW+4xz3O1Zmein9hWeGsxPZn2w0HcS9kB
 qvlD3TzF0bmJLlpoRXh3KdS/Iyv2/ThF5ThJsj7wemkS10TRhn8V2qt6YPbq9YU9ZPiSu9rcRig
 dRH4nL5pNMMtuyzpUx05d1g0ay6SzY7hNcPBRHmnDTuKPGDSsyxwihZxmgTdJONsE+/gPDB77qt
 qQmu5g==
X-Received: by 2002:a05:6102:3909:b0:5f5:4027:b6eb with SMTP id
 ada2fe7eead31-5f7238a80bamr2072920137.45.1769583965400; Tue, 27 Jan 2026
 23:06:05 -0800 (PST)
MIME-Version: 1.0
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
 <20260127181355.98437-4-scott.k.mitch1@gmail.com>
 <20260127105749.2e2059a2@phoenix.local>
In-Reply-To: <20260127105749.2e2059a2@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Tue, 27 Jan 2026 23:05:54 -0800
X-Gm-Features: AZwV_QhmoIzMYVb8lJAIxrj50O9ozFhgRRB3SoWRWRIE329sq2lOdRi2iqtLILo
Message-ID: <CAFn2buDn=jUNT2n8dAB0TceoQB5ebkC9nHejg43vDJyfpKMeqQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] net/af_packet: software checksum and tx poll
 control
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

> I don't think each driver should be doing its own checksum helper.
> It should be done at application or through libraries.
> All modern hardware does checksum offload, so if it doesn't probably
> a driver bug.

The goal from the app perspective is to set rte_eth_txmode.offloads
consistently across PMDs. Hardware devices are good but software
devices like af_packet don't provide a consistent experience. The
approach in this patch is similar to existing software eth devices tap
[1] and vhost [2]. In v2 I will share checksum code with tap to avoid
duplication and ensure they remain consistent.

[1] https://github.com/DPDK/dpdk/blob/v25.11/drivers/net/tap/rte_eth_tap.c#L559-L624
[2] https://github.com/DPDK/dpdk/blob/v25.11/drivers/net/vhost/rte_eth_vhost.c#L317-L357

> Needs to be a separate patch. Don't do two things in one patch.
> Not sure if some variant of the existing configure thresholds
> could be used for this.

ack, will split txpoll control. I'm not aware of any other way to
prevent poll if dpdk tx is faster than kernel rx.
