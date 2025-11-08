Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9C3CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Nov 2025 01:16:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A40A402B6;
	Sat,  8 Nov 2025 02:16:47 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 5CBB740261
 for <dev@dpdk.org>; Sat,  8 Nov 2025 02:16:46 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-29516a36affso11817945ad.3
 for <dev@dpdk.org>; Fri, 07 Nov 2025 17:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762564605;
 x=1763169405; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vh8d2LfgSlILJ3/g5YufOtJvMNZSbBzt7cb5wkuwE6w=;
 b=XfrVaBqy1gFVeaYfMuS5hh+rTLW/nMTpla18JHdMf2b8useCYKlSYcOdVXNktD2coP
 mqeGViXV1kXl6s+LW18s4vsXONgTIaKCmzD7AbqZXIADJRQIx4zqOrzZI386F3Frr7wF
 peaTXg8Aqj3mr4MMtwWuzY7UiklyEg8bab8AafdBp/cdFUt04F6vfMBiw3s4cl7k78zi
 yCQf8QClasZ4yUjr4OQ5IzDegAkbimKTZe7J/d5+sXnYBuXDwfEajYklWMe9XRDpNAll
 2BJOVin9Oh5lhVEVzvYI8X9Ya1+Z0PWM7PySlUcFvojbQo6pSHnKGhFMLzcdcH5ht/tL
 mK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762564605; x=1763169405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vh8d2LfgSlILJ3/g5YufOtJvMNZSbBzt7cb5wkuwE6w=;
 b=hcRmzTKqxX/hOGELvPWXRG2u8+tem1FLuC9z1mRpT/IIPPXnqxh12fUbPjl2fU0XdZ
 UWWs4RB448ATD/RzI62YMw9RytTWdmZmV/yQia675LGsBgZqBP8sT4Rk+pSz6J17GQPj
 O6RFgL43lkKyyQM9eWVm6206BofhhrUVwoIKJxbTyA4hHR36SwB8k7bNSWPRT8wnD04g
 xEIbthV3g+H2PoEw9ULNlNuXvH3IO2La9btdAM4KAhEZfIs1kum48wU1opObG9s+RRMp
 jvUD/bKddKTWVXiFyuoiaJl9/W4Mqo5dUfY4aHatteiBAd/SWiSfVEdGz9SRVl+SFSIZ
 gkaA==
X-Gm-Message-State: AOJu0YxREUv03mQBtGOfXt6KGF56YW/TXZc2wMHB7uUv5GZfWJb0DHS7
 FacUS1Gpd+8e9pDoB6caS2DxIYBbkAdzZGndEnP9Wy7Yni8vbPPN+/nA+chKYRvc+04=
X-Gm-Gg: ASbGnctAc5n4syE4dZYEgqqAygIUzadaJnUsYC8UdLQwVgcsOLu688WVSBYnuz4WAh1
 pmoQqkWmGhlJ0AIBRc8l1W6IjYoVjIAT1fDcCMWCDjyRf1V1/UQmu1YH0i//oJwKc9xKYWwWZd2
 62APDz/4SEccbY6BiUCjDwx6Nzjay0BWNgR6TVeA1wA8C6NE7EBAyt0ah9xx4/yBE+Ay+KLoT+e
 wfns97O6Sm9wXI4eUyguKHSKlzX90f6mHHWgoxVnjxtW1Y0Qtm1nPeN3w1dLskaeTBvLvuMOj+S
 VKsaTGViIyslM3/cXxcTmjeD0waJuJt02BOz5lflNe6vO5n8/DW+x7UiJKr6lcGOHaJ8upORMhn
 jgY6d2NbQGYoNsS/7iNvKPBdBiv2IvNK3UhfdoFDPbIPEjDNDdUwg/LhIfEpPqIpvIM0ghOuLon
 IJp5/jN9iohH9NwFEASBVkDMC0hnvgi1bU2sI99bAjOE/5
X-Google-Smtp-Source: AGHT+IHwbGHp2j5dnTY4wh6pw9B2hSEnpNUzLKmyobN0bmSwDoqZTks6oBcnkc/jVHi+0Kh2jT1yVw==
X-Received: by 2002:a17:902:e947:b0:294:fc77:f021 with SMTP id
 d9443c01a7336-297e56e1291mr11104425ad.49.1762564605320; 
 Fri, 07 Nov 2025 17:16:45 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651045bf0sm72782535ad.48.2025.11.07.17.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 17:16:45 -0800 (PST)
Date: Fri, 7 Nov 2025 17:16:42 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yang Ming <ming.1.yang@nokia-sbell.com>
Cc: dev@dpdk.org, bingz@nvidia.com, dsosnowski@nvidia.com,
 julien.meunier@nokia.com
Subject: Re: [PATCH v2 1/2] net/mlx5: enhance socket file path
Message-ID: <20251107171642.5b843c92@phoenix>
In-Reply-To: <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
References: <20241213092444.2987-1-ming.1.yang@nokia-sbell.com>
 <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
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

On Fri, 21 Mar 2025 21:27:49 +0800
Yang Ming <ming.1.yang@nokia-sbell.com> wrote:

> The directory /var/tmp may not be writable in a container's
> read-only mode. To address this issue, use the DPDK runtime
> directory as an alternative when /var/tmp is not writable.
> 
> Cc: bingz@nvidia.com
> Cc: dsosnowski@nvidia.com
> Cc: stephen@networkplumber.org
> Cc: julien.meunier@nokia.com
> 
> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
> ---
>  drivers/net/mlx5/linux/mlx5_socket.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/mlx5/linux/mlx5_socket.c b/drivers/net/mlx5/linux/mlx5_socket.c
> index 6ce0e59643..270a105f1d 100644
> --- a/drivers/net/mlx5/linux/mlx5_socket.c
> +++ b/drivers/net/mlx5/linux/mlx5_socket.c
> @@ -20,7 +20,8 @@
>  
>  /* PMD socket service for tools. */
>  
> -#define MLX5_SOCKET_PATH "/var/tmp/dpdk_net_mlx5_%d"
> +#define MLX5_SOCKET_DPATH "/var/tmp"
> +#define MLX5_SOCKET_FNAME "dpdk_net_mlx5"
>  #define MLX5_ALL_PORT_IDS 0xffff

Using /tmp or /var/tmp is non-standard on modern Linux distros.
Systemd based systems use /run for this.
Would be better to use abstract sockets, but that might break some containers.

Example:
$ ss -x | awk '{ print $5}' | grep -v '^@' | grep -v '*' | sort -u
/home/shemminger/.cache/ibus/dbus-d8xKr3Ya
Local
/run/dbus/system_bus_socket
/run/gdm3/dbus/dbus-6Kd7KbFO
/run/gdm3/dbus/dbus-RNBHo0m9
/run/systemd/io.systemd.ManagedOOM
/run/systemd/journal/dev-log
/run/systemd/journal/socket
/run/systemd/journal/stdout
/run/systemd/notify
/run/systemd/oom/io.systemd.ManagedOOM
/run/user/1000/at-spi/bus
/run/user/1000/bus
/run/user/1000/.dbus-proxy/a11y-bus-proxy-HBPCF3
/run/user/1000/.dbus-proxy/session-bus-proxy-1HPCF3
/run/user/1000/.dbus-proxy/system-bus-proxy-HIPCF3
/run/user/1000/emacs/server
/run/user/1000/.flatpak-helper/pkcs11-flatpak-16622
/run/user/1000/gvfsd/socket-r1TYSmLV
/run/user/1000/gvfsd/socket-Rk6Pe47X
/run/user/1000/pipewire-0
/run/user/1000/pipewire-0-manager
/run/user/1000/pulse/native
/run/user/1000/speech-dispatcher/speechd.sock
/run/user/1000/wayland-0
/run/user/1000/wayland-proxy-4315


