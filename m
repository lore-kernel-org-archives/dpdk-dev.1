Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2A6C369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 16:16:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEA9240279;
	Fri, 25 Apr 2025 18:16:03 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id EE2594025E
 for <dev@dpdk.org>; Fri, 25 Apr 2025 18:16:01 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2ff62f9b6e4so327127a91.0
 for <dev@dpdk.org>; Fri, 25 Apr 2025 09:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745597761; x=1746202561; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=svgYU2YeU7+lTUtyUziGr1Ds0WAR0XU+XnCuQibxreU=;
 b=YY+9dF1fAV3H8b1rox+aBYXfQFpjaTX2FssBH1ZRrjSnrMYCir3gaqFCsX8xAxsoEQ
 YF+rtppx4sJ1OcF2RBCb83qL47eYG4AEVM6QVhiVGketaU2nANOacv5kN5yuLbEAieeT
 Xbq3vB7MZoUdkKJBpLmz2+CpvV8Y2XUixSZLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745597761; x=1746202561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=svgYU2YeU7+lTUtyUziGr1Ds0WAR0XU+XnCuQibxreU=;
 b=dppYAK0wvvVvSOjnZoaunWwSIOpqME5yV3a0RTNICz9eTcaMQVwZ/V7PBMPRppo4D0
 M0oLTMD4dUs2xVaotz05t7SMK1/xEeCy4u3zDeNy63QUVGCuke436722r1nL5X6Tu1fT
 2zsw0jxUGdN11G504BHyeefH4A+6MEWJtNYteJU1DCplrhpSzV5qxH+hAD6Is4ptKO4T
 VX6pwijv+282Pn42BV1InBhGDhwekgitZHKy/maC2f4oWpLeXYSddRc9EvLND7SGZQSm
 m9o30KnqV40cKRxcQbLJY6pqR1KOqKuw5HAUd46UATFdbKb2I3O+2o4x44ipFPNMOmn3
 VkFA==
X-Gm-Message-State: AOJu0YzFhKr4gL6kFxbVJugS0kDpf5T4BwMGOAtFIoGnPxtoKmTnMaBJ
 3gkQdRcv+Za30h3vjMpcR5XRvwxlZAeZaavMQl5aDMSkaGaTNT3o96DJyypH86Ti3JQ96uyDLP3
 DDIK7kUWgfJ+HGFwc8nD8fQmFdm4Yy7tyXulj0A==
X-Gm-Gg: ASbGncsLofLCWpyrtz/JmqMTSl8fJDIVLzv1htLD9yIlVb9u42RVjM7pDZI3SFtIqKZ
 Ng/lnOlqfLiH8kCtoRBW0Hjks5JCyz2/sAUqd9V0Rbg0COeh0yVfPCK4PxDzG2bPCfXYhKuEfiI
 590HlQSxTICp57PhhHsF+vX+/2FOF/tKJ+TUa/hwEMPq4iblNP8Uu4/xey
X-Google-Smtp-Source: AGHT+IHgdk0ANHCQ2ONXNwJom9477YTXx604lYFfuF98Wrzy24xsqMN5jzRC+82FpvWtoUa6CMnN1YApcsFX/MDbGME=
X-Received: by 2002:a17:90b:1b52:b0:2fe:b45b:e7ec with SMTP id
 98e67ed59e1d1-309f7eb5d77mr1557378a91.8.1745597760717; Fri, 25 Apr 2025
 09:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-2-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-2-luca.vizzarro@arm.com>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Fri, 25 Apr 2025 12:15:50 -0400
X-Gm-Features: ATxdqUETpK0mTWl-ha_8SiVR8KTCEcnbAMMYNUDsYh7WRRiqCHzJ_P-kAy3GdWI
Message-ID: <CAKXZ7eiy=qx5r0M4ZZawpYBXfcS-zhhgn=dm72tjpbruPd3ouA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dts: escape single quotes
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
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

Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>

On Fri, Mar 14, 2025 at 9:19=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:
>
> When making any command a privileged one in a LinuxSession, there
> currently is no consideration whether this command already includes singl=
e
> quotes. Therefore escape the existing single quotes before making the
> command.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> ---
>  dts/framework/testbed_model/linux_session.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework=
/testbed_model/linux_session.py
> index 7c2b110c99..6c6a4b608d 100644
> --- a/dts/framework/testbed_model/linux_session.py
> +++ b/dts/framework/testbed_model/linux_session.py
> @@ -67,6 +67,7 @@ class LinuxSession(PosixSession):
>
>      @staticmethod
>      def _get_privileged_command(command: str) -> str:
> +        command =3D command.replace(r"'", r"\'")
>          return f"sudo -- sh -c '{command}'"
>
>      def get_remote_cpus(self) -> list[LogicalCore]:
> --
> 2.43.0
>
