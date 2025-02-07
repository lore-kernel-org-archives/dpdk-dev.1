Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF78C0219B
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 17:56:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C13042ED5;
	Fri,  7 Feb 2025 18:56:06 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 432A842E90
 for <dev@dpdk.org>; Fri,  7 Feb 2025 18:56:05 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2f9b9c0088fso3886091a91.0
 for <dev@dpdk.org>; Fri, 07 Feb 2025 09:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738950964;
 x=1739555764; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKqjIeKz13kM2E1IP04h480zBz5TUlBqaHFwJkPeFYU=;
 b=LsgQLNnHYOwIwTkGb8WX/LgopRFmpzmuEWL4hcejzIYASJnW8bbH+ICjYlXxWtfMzr
 1oBVuEVqaFh6sb3HZD0NP+SMjdxTh9fRys3mQty2vggw/mewXKx7LSTUIcT6mMHtNTSW
 LjcY9tF7vqvMRTS4w51+W6nlKbQg+oQ0N2rK+LNfG/s1qJWpjUw8ttdp3vYqlDGRokbR
 9hmSwOnze2vlXNjw8Rck6Ui+hoS7QZd7YTrB0RvNoA0NfuKc2XOgrnJnqxkf0qC6sJNI
 jrQK4eQ4DGTdeym1dbQncnFhrQzcyHEJTD6sftgcuz8HiIF9E5EGkycksctXPPPNMIwF
 fmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738950964; x=1739555764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RKqjIeKz13kM2E1IP04h480zBz5TUlBqaHFwJkPeFYU=;
 b=Oqlwwhy0Le0VpDo1YSmRUvwyp3gvxxVa70xDAOys7xf2dhUz+fIlCHrvY/Xq+Ou47r
 Ymygl/fE43e/dK8Qn5erY7lFskp3Dpq6GZG021V5vAUDHrZSinPFXQiY30IQ6eKfg+iQ
 tErBTDQxSOtxNg30NwvhO5A3L4ruACLwa4O0AK4S1uLwSLfdBfozEkO6L0wi/0+Zo3Aq
 QL8JdJlNyBT8ylFx6A0r4vEhX2KPG3tb0kLs4S7jMiofFQCBOVZ5ziOO0+pM1loIKLps
 ruSSSWAbPUTL/ibT4gXv+3izKEgNbmUqLFVQH8QvdocfkJXXK0wkZ0qrulvZw2VR/ACj
 QIRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsOiTWa/0avNd+OUgt65BmQF9Zz+Ny13T17HtVe1Z7+sPZf4kbxwQ602ptHnqDyOe+mt4=@dpdk.org
X-Gm-Message-State: AOJu0Yy4GAWj0l0NC3soNSgkKvZ8Dr7DB8fUzd3LY5wV+tIrNfMSUKTG
 4qkDoejY9OsYfHn2RlSvWgzL3FCDinKOS890dbN2jd8seNDiiCLKB3ye1Dv12Ts=
X-Gm-Gg: ASbGncvf+b5uJLUzx3zn7HV0RA6ZbuCQIBJIxc909/rm+mYFnX4PiBTtzrEoyNXRwOS
 s4fb0L9nYFx/Y4dDDm9IBLU+wPkSdjOs/ZbcaYfl9k3RAdLKmxqVEeIKS51DkzlJA1wc9MNnNDB
 ks1Y3HFRuBZcDfxOf9EUm5rQGXeNo6OI1vks9WzFbyu+zM9EqB59DRAdZW2Evs/bQ5g76EebItr
 lOocczAZOk3MsQ+OGVnWHHNACxAPiqT/T7KkCCZNVhfkh3qOvN2j1Pc1Roj5eJsjn4mL8IEthiO
 fUBIWSt3rXZhFqedWxIqyIq/EED5QlzM5+7v0Se3dDCXzuPv8Sq+yEyp0pxEmRrbDKEx
X-Google-Smtp-Source: AGHT+IHzKqnOhdFh0XzmXNYMpTCCFrvNF5P1pqKtd33wt8c36v0W0wKqyD1C2Yg64jKNuMp4uwumrA==
X-Received: by 2002:a17:90b:2e48:b0:2fa:30e9:2051 with SMTP id
 98e67ed59e1d1-2fa30e9213bmr3202640a91.5.1738950964448; 
 Fri, 07 Feb 2025 09:56:04 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9e1d60b71sm5864780a91.8.2025.02.07.09.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 09:56:04 -0800 (PST)
Date: Fri, 7 Feb 2025 09:56:01 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: anatoly.burakov@intel.com, bruce.richardson@intel.com, dev@dpdk.org,
 ian.stokes@intel.com, jochen.behrens@broadcom.com,
 vladimir.medvedkin@intel.com
Subject: Re: [PATCH v4] drivers/net: use 64-bit shift and avoid
 signed/unsigned mismatch
Message-ID: <20250207095601.49aa82a8@hermes.local>
In-Reply-To: <1738783944-10172-1-git-send-email-andremue@linux.microsoft.com>
References: <1735246770-731-1-git-send-email-andremue@linux.microsoft.com>
 <1738783944-10172-1-git-send-email-andremue@linux.microsoft.com>
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

On Wed,  5 Feb 2025 11:32:24 -0800
Andre Muezerie <andremue@linux.microsoft.com> wrote:

> This patch avoids warnings like the ones below emitted by MSVC:
> 
> 1)
> ../drivers/net/ice/base/ice_flg_rd.c(71): warning C4334: '<<':
>     result of 32-bit shift implicitly converted to 64 bits
>     (was 64-bit shift intended?)
> 
> 2)
> ../drivers/net/ice/ice_dcf_sched.c(177): warning C4018: '>=':
>     signed/unsigned mismatch
> 
> The fix for (1) is to use 64-bit shifting when appropriate
> (according to what the result is used for).
> 
> The fix for (2) is to explicitly cast the variables used in the
> comparison.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Applied to next-net with some rewording of commit title.
