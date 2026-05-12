Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76A9CD4F24
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 15:30:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC67D402C1;
	Tue, 12 May 2026 17:30:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 835E4402A7
 for <dev@dpdk.org>; Tue, 12 May 2026 17:30:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778599802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7jQrqwqjYpR53ImIzsLKYH7KzPxveP4IunQyVMq/0Rg=;
 b=DvFUpGwkBsT8s4etaLn5tZ0ak/6E7UvBKT2sTawqNdoEN+dmrTXCJqD7kG0XfelFiBtF5X
 IDruFuJRmWBiJXpxM4yWAPjfwGGV7eDxrFEkB3DCVpf7IkRDLmG/z4kc/YPWY7bWE2g11r
 U6iehSn6B7fYTbZ1KwkZFuDlpNX/3tQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-iy_WSOgsPX6-Iw0P4ZoFzg-1; Tue, 12 May 2026 11:30:00 -0400
X-MC-Unique: iy_WSOgsPX6-Iw0P4ZoFzg-1
X-Mimecast-MFC-AGG-ID: iy_WSOgsPX6-Iw0P4ZoFzg_1778599799
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5a3ff732c58so4095849e87.1
 for <dev@dpdk.org>; Tue, 12 May 2026 08:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778599798; x=1779204598;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jQrqwqjYpR53ImIzsLKYH7KzPxveP4IunQyVMq/0Rg=;
 b=UZ3rvNs+De9dhur1D3+RCRsPASI4/LFGPyVY+/sCjyh1sR6GS+NBxYV5NXKIsh2yb1
 Sh1LBKaFbZTfXuB2yUvRfmnKSwLdPvyjmzVoqo9olVKiqnwwEDtZJgmTlcniONRtvre9
 +ZYrjjrIWcV3y0N3bJsVgS+sEsxqWMAsxBIQXYcei11/JVhWQwKoJjLwmAq+2vdfjKug
 INNn/hNlodW5hDxHeao0zDHMiAmcR/YZx7s85TD7xbd4gnd/ntfH7rATUXT/WFDMWSjN
 dO19UZM1nTVdqmZUJ1jhVKJ+lns3OVUULurXj4xhzfoT9mpAi19IoRxqtJTSrTdBn9Wv
 EoKQ==
X-Gm-Message-State: AOJu0YwdgeLuarWAhpibwDmbG9Cm50jsqqUcqdILM5ZeYw47nvQFskvs
 naJ+q7AjJ1fNTTknaltXhVEW9gW8McR1VMBzT9nPCGcZIz4Xzi132DkTF0gz3SoSxzaIkZ8b17z
 82XUvGvWkMQpE3VHL+kYNIhcmXRU2qFBMdf0+9IGbvi4tloKkALMXv8D0tLxJ4f4ygqPLHJOksl
 /qKEB498zrNo1Od8V8LxQ=
X-Gm-Gg: Acq92OGmK5ge8NoI5YXiGNNLnh2FaOL1UDvDC4XsOoTaLgCKGa/ngzRY6FHg05e9e4H
 DXtWFbElyGvUHw+2xgc32zrSwmb1dv3iXFCqcL9xH+PxibhD8S+hUhXY4nTEWNhe3wH8MfeZc44
 +cJeDB/mOge+NkasLp0qzF0s9LNfdvFfHMXxguqN/5G10mIdgl1KuB0nmhU4WcFSxZnTM6iVEqm
 WBM/MkH8htUe6Z1YakN+UW9EWeQIPRF1sNiVihnJ0As2FIpUPRpDjvqL+Ye/6HeT8pk
X-Received: by 2002:a05:6512:33d3:b0:5a8:64c4:38cd with SMTP id
 2adb3069b0e04-5a887cde867mr10316041e87.21.1778599798381; 
 Tue, 12 May 2026 08:29:58 -0700 (PDT)
X-Received: by 2002:a05:6512:33d3:b0:5a8:64c4:38cd with SMTP id
 2adb3069b0e04-5a887cde867mr10316017e87.21.1778599797755; Tue, 12 May 2026
 08:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260511233350.79402-1-arinkharkar@gmail.com>
In-Reply-To: <20260511233350.79402-1-arinkharkar@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 12 May 2026 17:29:46 +0200
X-Gm-Features: AVHnY4IJQFEUFiUGeJIWTUcgtdkJh48hmRNiWr84X_ASRLr1NYwSuANRZuYXb7U
Message-ID: <CAJFAV8zBGUVp-Df3aqY_pUw-JZpVqJfXERXsw4oQ+k2_TJbu2Q@mail.gmail.com>
Subject: Re: [PATCH] Fixed outdated documentation on the hello world doc,
 which incorrectly stated an easier way to launch the lcore_hello function.
 The example program uses the simpler version and the documentation stating it
 as an "equivalent and simpler" alternative is moot. It is now the default.
To: Arin Kharkar <arinkharkar@gmail.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I5vsuPxCk5Bp7-HEh756R39HuObS2FiFI25XqTmqK7Y_1778599799
X-Mimecast-Originator: redhat.com
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

Hello Arin,

Thanks for the patch.

On Tue, 12 May 2026 at 09:57, Arin Kharkar <arinkharkar@gmail.com> wrote:

You'll have to add a title so that your commitlog does not end up as the title.

>
> Signed-off-by: Arin Kharkar <arinkharkar@gmail.com>
> ---
>  doc/guides/sample_app_ug/hello_world.rst | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/doc/guides/sample_app_ug/hello_world.rst b/doc/guides/sample_app_ug/hello_world.rst
> index 5bfd4b3fda..b7167aa345 100644
> --- a/doc/guides/sample_app_ug/hello_world.rst
> +++ b/doc/guides/sample_app_ug/hello_world.rst
> @@ -70,12 +70,4 @@ The code that launches the function on each lcore is as follows:
>      :end-before: >8 End of launching the function on each lcore.
>      :dedent: 1
>
> -The following code is equivalent and simpler:
> -
> -.. literalinclude:: ../../../examples/helloworld/main.c
> -    :language: c
> -    :start-after: Simpler equivalent. 8<
> -    :end-before: >8 End of simpler equivalent.
> -    :dedent: 2
> -
>  Refer to the *DPDK API Reference* for detailed information on the rte_eal_mp_remote_launch() function.
> --
> 2.43.0
>

Please also drop the associated "Simpler equivalent. 8>" and ">8 End
of simpler equivalent." comments from the example source code.


-- 
David Marchand

