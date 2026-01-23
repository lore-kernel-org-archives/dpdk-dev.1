Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E383D77882
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 16:57:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FC0F402F0;
	Fri, 23 Jan 2026 17:57:42 +0100 (CET)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by mails.dpdk.org (Postfix) with ESMTP id EA4664021F
 for <dev@dpdk.org>; Fri, 23 Jan 2026 17:57:40 +0100 (CET)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-78fdb90b670so23021917b3.2
 for <dev@dpdk.org>; Fri, 23 Jan 2026 08:57:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769187460; cv=none;
 d=google.com; s=arc-20240605;
 b=bAf067dSwNB3LRIOs7FiRnDJCXqcNTc0alNjsNGzQZY+tQACSbA7ocjpq6XNgtJGbk
 n17JnzjFAlzuYnW/O7Hy0mjlE8bCThZTLeMTGX4x5nuNbRc/zGqPjLuZFAuHw0jTID3H
 Ab+HFlIsdWbGGqabvGUIXUkIhUzlmaa3hcqUPvDE+Fh7tITMz8nrj8/LBFtyBXc/dW1O
 GzrLF2/s47yHndo6VX+n0xK+w9P5cGsA7ipxyNA4RWpzhMyuVbOwtwTypeetc32Q0E0+
 94CUywLd8S8mslfoTaMRoLqs/26LfNwBgnD8pJHq1Zefi/aOT9DmfuOjHfpdu8ruqd4Q
 vOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DAAGX7E50UrwL4CgikRfg80+Cb6EnD49xnhvQP3z90o=;
 fh=WeETf7GvmMgAvsMokBteLbd5L8jDyQ4Cq9m2s817608=;
 b=O/D9Xy9Ocg/xtijIaXr8grpAFE0V7DC8GgzbF9iDf8JjI81GF9cBQU3JRfKe14CjLt
 0EscIlOTRexRQyh13pZEAq52v8WDULGjFYHHYa219eWrWwhBB8jC53f5GSsnGzSTD3qa
 mkaiGxAYNv3V1ojEbwaKupp4Osv7n7BDiDlJT2oVIixUhL01AJq7h8moUGdoRqBNmOou
 v6+HMXJ6O8lJnNxqGGK9YMxE/ZMKb2c+hdA7CaCUkkS98x4uCtIfaVRMpOE1YrK7aV/T
 1lFhRMnNrN58816fyBUsuZAlZvFUhN3BdG8eKJE/c0jXYdPGm6xOG6LCp2nVFI+6xF1D
 330w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769187460; x=1769792260; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DAAGX7E50UrwL4CgikRfg80+Cb6EnD49xnhvQP3z90o=;
 b=KCQr8d24VUJEBKmwoIQEn54ynmzSfVZ8YCIBDTRln4YBLc7FOBLN534cDcQZWo9XZo
 R2C9QjjYdtyqYJYw56Uls6UEXxJBccCX98AHLeLLQBpP0LjltaUUNq3jOhImz17mhto7
 sftu8MAJ43LMpgdDeJA1stq7fmGcB8ZKMDOAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769187460; x=1769792260;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DAAGX7E50UrwL4CgikRfg80+Cb6EnD49xnhvQP3z90o=;
 b=uDO29ZB4wI7bM3q+BYCg2JgKgUkREf9zqx5jCBy5oZcOOAFNbq4jH5nPSZBNUtnK1D
 L9N/ISDlD4aPLaBtXtcJmvSe/hdCa5p5yCTv1Uuurkm+PgWpRB55SpJDSxvnDZssUCZy
 koZQX9809wg6duzOqNeqTujuGjlBnCyn0RPGR64iB6UR6n4EVNjGobSe/0OYUEZwmcpd
 ICqXUwKINq1VtFED6QtaZbT+1UsCX9HYZR8S+iNgwWOsb1ergkBXJx+0CoXLRmFrE0uu
 5+PebI2eET1pZXbtCsUzIy9qBw5jMVbkir63ANGY5rMYr67jmgSmskzkHiUY0lqteaRe
 kK5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtqo70ZMMH0PH9CEZcOIht3Z57gB7KR5TChOWLcCkzmxq2x3PbKRJuKBR0veGE+TyhMB4=@dpdk.org
X-Gm-Message-State: AOJu0Yyuwb1ZDTbYOifNIuL1uSx0EpCOhXw0eUoQMs/jR+Wwk1arQVYf
 mCQ6UdPxBliovAEIQW/q7gAT0Mpl9ysfAqeVYNq3KpHZjrXSKPC1NQspx6aB2dH5bIgekuuxC91
 qhGxPChsdmGtzvvOnjtnolqUmnjlLG7xSNX1L4MwsZw==
X-Gm-Gg: AZuq6aIJfOEq+K28UNdmeMufymB0n34pX0xf2gGghtBQ8HWE1/Afsr/qXfbd8/AW/eX
 9MxBoC3i0hSXw65ZP2hujR82BQ4JFGHm0kkDLjUO0Kc6rTgMFTP39rhMZZMfG31EJZMZOW4VYS2
 C889A2DH3YAA0wXSmcmbLWeiPeYGWDp7J3lGIIaWmLyZc8PGf40RXC7jnGry7WfAn4jYy6rKgOy
 jD1htY9zQdhG0vlem9xyt0a1BU+7pJ0gZHKtmxI8nmeYQkzxqRkmjXu8OBGN2BBHOmjEdYRLYI4
 ommEf/jMvQ==
X-Received: by 2002:a05:690c:f03:b0:786:4860:21fd with SMTP id
 00721157ae682-794399db5ecmr27944327b3.39.1769187460213; Fri, 23 Jan 2026
 08:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20260122214424.322422-1-abailey@iol.unh.edu>
 <20260122214424.322422-6-abailey@iol.unh.edu>
In-Reply-To: <20260122214424.322422-6-abailey@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Fri, 23 Jan 2026 11:57:29 -0500
X-Gm-Features: AZwV_QgTNSNEBDwyGkjy42ww3NnYSgblRAk1zcytVArcffLoekV-rLReeg80zhc
Message-ID: <CABD7UXNqaWDd2HVV96icqYgkUdfWs6GTo0xhYRZ2gdTr_40K1A@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] dts: automate VFIO-PCI modprobe in node setup
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, probb@iol.unh.edu, dev@dpdk.org, gakhil@marvell.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Jan 22, 2026 at 4:44=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:
>
> Currently, users must modprobe VFIO-PCI before running DTS when using a
> non-mellanox NIC. This patch automates the process on test run start up.
> In addition, if the SUT is expected to use a subset of a few QAT devices,
> VFIO-PCI must be loaded in a separate manner. This patch adds this
> distinction.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>

Other than the comments I left on the previous patch, looks good

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
