Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B596AC5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 16:15:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB99C400D7;
	Fri, 30 May 2025 18:15:04 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 599A840041
 for <dev@dpdk.org>; Fri, 30 May 2025 18:15:03 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso21573075ad.3
 for <dev@dpdk.org>; Fri, 30 May 2025 09:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748621702; x=1749226502; darn=dpdk.org;
 h=in-reply-to:from:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=C9HzHpQ4x9QbLtt2nMsALygtnjwdzrHPUyWDQ/Zcpko=;
 b=FxOO1uUgJJW8k2KpCsHkXxt6KAHPIyRMdcCr+7jTFQJkcwjFfChVm5xLbCCLEANRTh
 UQdL3/knu3K8AAv7Bs3qDQ5GnU/AJV3CGHtXrgtuuzMiUtD5mpmIZqhEjwnLVREOpw0w
 PXJgTsrGb6cZy2Fh7POD+/1JxPtLVi3Uv+buUottfxbV+Qd2eZwFYXujJK17nGezEYPa
 0iEFBO5hpWUtVzRFO6pUN2B+yTw4cn3BEeaZdvXa3PrQ7yQQU9XwOraVIMHUfSy3DFb0
 aZoRPzP6jHwtajYYyvV5nRy0irLWANRb52CXWgVXcrUhhmbul+yXuE/idrN9Y42XdIfY
 OEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748621702; x=1749226502;
 h=in-reply-to:from:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C9HzHpQ4x9QbLtt2nMsALygtnjwdzrHPUyWDQ/Zcpko=;
 b=cZKDFMv7t4oWbD23mHVyqjSF3PD78XSqfNauM6K/HJqaP/MpM1Z5OUjGvVte+WBkI1
 glR+jH8/pkHj2L+sJWM4mZIeDCgwuz39QLikPb6Fe9/x5zj460UwqYKnXCUj8YAFiw9k
 XjlFwIUjOfc1tHBswrI2wnn30h5y0Ju7NVZV9N/nGloGS/9J2E/7krBbF8SP4ZsW26lo
 h3DstXumMejNK6rtPEnAJzNm7x/dYnEEXiVJCV4r4/0Ooh6B+vbf18863niBhPwpqXvO
 qnTeMmyeZ3aGAltM7W+OIDI42y/zaEabOOrApG1Jt8FPtPaX0Gw3Y/qWXibu3W26xfOj
 UuBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRhGvEOoIN12N2Xp0qAYqTsH/0lRxNDD6kLUF3iKJ4Yrmu+qQllqAFUIi53LD8r/ANdDA=@dpdk.org
X-Gm-Message-State: AOJu0YzlXnElhGA4TGXxOLh90ti+5b9/G4SdoMP957fYBF/qng7+4BD9
 +MVcE4P+kIOlOTfBPmps/zr/sGBGrWdg3UJAUcQu4BYIBJI2Hf7gaIj3
X-Gm-Gg: ASbGncs6SIxE+ZCpHg3jZ+8iVZ8kqrBqVFKZDp9QC2njA8XN0+hLmddYfmNR9ryTHuq
 S7+371frq6soQnh4SLpwQniyHPYyOGqwZZW+NxObcIQGOEgczZeDEE/gOu3tlcBghLLFpU7V1xn
 /sgIgyVU4QPR+AIxuCJeDBzxq0wb/2TxyafM1lPpLtCOpyJhYe8dmoIk0+ehQi9poFQjPuxPGAM
 H8J1LhhwIuRTE0A85nP8HceO3mQB00toGcNlLCC1lAFnhoJuLNXTC5RakVsGQ20+j7inyMwinpr
 k9DcjSciQL2pDzDVJbFnQlJshJF1xAJZpqpAuEttn0Bd5dq2z9/AVmE3/nkrDPwfd58TgeiW6i8
 2VO7ilVPHxw==
X-Google-Smtp-Source: AGHT+IGbQvhT6ByTkIuq5FPMQJNBoXntQ0au+d2Nq4qTyvOUInUMgBQZw9cejvqs5MQP2UaoCcvCow==
X-Received: by 2002:a17:902:d2ce:b0:234:b131:15a with SMTP id
 d9443c01a7336-235298f1918mr61963535ad.4.1748621701900; 
 Fri, 30 May 2025 09:15:01 -0700 (PDT)
Received: from [192.168.31.141] ([122.231.206.50])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506be2622sm30239765ad.102.2025.05.30.09.15.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 May 2025 09:15:01 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------C5VT2WJSlL0swbHRaLsUawxr"
Message-ID: <4fc0eb6e-5923-4af6-9f1b-6ace4a6d827f@gmail.com>
Date: Sat, 31 May 2025 00:14:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] crypto/ipsec_mb: fix QP release in secondary
To: "Ji, Kai" <kai.ji@intel.com>, Yang Ming <ming.1.yang@nokia-sbell.com>,
 "dev@dpdk.org" <dev@dpdk.org>
References: <20250314103638.2198-1-ming.1.yang@nokia-sbell.com>
 <20250407052532.1913-1-ming.1.yang@nokia-sbell.com>
 <20250407052532.1913-2-ming.1.yang@nokia-sbell.com>
 <6d31ea07-8bbb-4e9c-ab88-be50e0132e31@nokia-sbell.com>
 <DS0PR11MB74583A392F4BEEB1E2AC9F2E8188A@DS0PR11MB7458.namprd11.prod.outlook.com>
 <7cf98921-1ca2-4707-a0fd-609c1d2cce65@gmail.com>
 <DS0PR11MB74589B3EB4B98A5DE37AF748819CA@DS0PR11MB7458.namprd11.prod.outlook.com>
From: Moses Young <mosesyyoung@gmail.com>
In-Reply-To: <DS0PR11MB74589B3EB4B98A5DE37AF748819CA@DS0PR11MB7458.namprd11.prod.outlook.com>
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

This is a multi-part message in MIME format.
--------------C5VT2WJSlL0swbHRaLsUawxr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/19/2025 6:46 PM, Ji, Kai wrote:

> Hi Yangming,
>
> How did you configure the queue pairs differently between the primary 
> and secondary processes?
>
> The application must call rte_cryptodev_queue_pair_setup() with a 
> unique qp_id for each process. This implies that each process should 
> receive distinct queue pair configurations at runtime. From what I can 
> tell, it’s likely that the secondary process is still using the same 
> queue pair as the primary process.
>
> Regards
>
> Kai
>
>
>
>
> ------------------------------------------------------------------------
> *From:* Moses Young <mosesyyoung@gmail.com>
> *Sent:* Monday, May 12, 2025 11:10
> *To:* Ji, Kai <kai.ji@intel.com>; Yang Ming 
> <ming.1.yang@nokia-sbell.com>; dev@dpdk.org <dev@dpdk.org>
> *Subject:* Re: [PATCH v2 2/2] crypto/ipsec_mb: fix QP release in 
> secondary
>
> On 5/7/2025 11:25 PM, Ji, Kai wrote:
>
>     Hi Yangming,
>
>     PID check is implemented here:
>     https://github.com/DPDK/dpdk/blob/75f179ebe347b6098cf3af26d3d3b7168fe3fe24/drivers/crypto/ipsec_mb/ipsec_mb_ops.c#L376
>     <https://github.com/DPDK/dpdk/blob/75f179ebe347b6098cf3af26d3d3b7168fe3fe24/drivers/crypto/ipsec_mb/ipsec_mb_ops.c#L376>
>
>     Can you share the steps to re-produce the error ?
>
>     Regards
>
>     Kai
>
>     ------------------------------------------------------------------------
>     *From:* Yang Ming
>     *Sent:* Thursday, April 24, 2025 15:26
>     *To:* dev@dpdk.org <mailto:dev@dpdk.org>
>     *Subject:* Re: [PATCH v2 2/2] crypto/ipsec_mb: fix QP release in
>     secondary
>
>     Hi,
>
>     On 2025/4/7 13:25, Yang Ming wrote:
>     > From: myang <ming.1.yang@nokia-sbell.com>
>     <mailto:ming.1.yang@nokia-sbell.com>
>     >
>     > When a secondary process tries to release a queue pair (QP) that
>     > does not belong to it, error logs occur:
>     > CRYPTODEV: ipsec_mb_ipc_request() line 373: Unable to release
>     > qp_id=0
>     > EAL: Message data is too long
>     > EAL: Fail to handle message: ipsec_mb_mp_msg
>     > EAL: Fail to recv reply for request /tmp/dpdk/l2hi/mp_socket:
>     > ipsec_mb_mp_msg
>     >
>     > This patch ensures that a secondary process only frees a QP if
>     > it actually owns it, preventing conflicts and resolving the
>     > issue.
>     >
>     > Signed-off-by: myang <ming.1.yang@nokia-sbell.com>
>     <mailto:ming.1.yang@nokia-sbell.com>
>     > ---
>     >   drivers/crypto/ipsec_mb/ipsec_mb_ops.c | 7 +++++--
>     >   1 file changed, 5 insertions(+), 2 deletions(-)
>     >
>     > diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
>     b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
>     > index 910efb1a97..50ee140ccd 100644
>     > --- a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
>     > +++ b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
>     > @@ -138,6 +138,7 @@ int
>     >   ipsec_mb_qp_release(struct rte_cryptodev *dev, uint16_t qp_id)
>     >   {
>     >        struct ipsec_mb_qp *qp = dev->data->queue_pairs[qp_id];
>     > +     uint16_t process_id = (uint16_t)getpid();
>     >
>     >        if (!qp)
>     >                return 0;
>     > @@ -152,8 +153,10 @@ ipsec_mb_qp_release(struct rte_cryptodev
>     *dev, uint16_t qp_id)
>     >                rte_free(qp);
>     >                dev->data->queue_pairs[qp_id] = NULL;
>     >        } else { /* secondary process */
>     > -             return ipsec_mb_secondary_qp_op(dev->data->dev_id,
>     qp_id,
>     > -                                     NULL, 0,
>     RTE_IPSEC_MB_MP_REQ_QP_FREE);
>     > +             if (qp->qp_used_by_pid == process_id)
>     > +                     return
>     ipsec_mb_secondary_qp_op(dev->data->dev_id,
>     > +                                             qp_id, NULL, 0,
>     > + RTE_IPSEC_MB_MP_REQ_QP_FREE);
>     >        }
>     >        return 0;
>     >   }
>
>     Hi Experts,
>
>     Is there any chance to review and accept this patch?
>
>     Brs,
>
>     Yang Ming
>
> Hi,
>
> David. Thanks for your feedback. I will Cc maintainers in next version.
>
> Kai, Thanks for your feedback. Here's our test steps after applying 
> the previous patch called "eal: prevent socket closure before MP sync" 
> in this serious:
> 1. Start the primary process: Run the DPDK primary process with the 
> IPsec MB crypto device.
> 2. Launch the secondary process: Start a DPDK secondary process using 
> the same device parameters.
> 3. Exit the secondary normally.
>
> On secondary exit, error logs show below as my commit log's description:
> CRYPTODEV: ipsec_mb_ipc_request() line 373: Unable to release qp_id=0
> EAL: Message data is too long
> EAL: Fail to handle message: ipsec_mb_mp_msg
> EAL: Fail to recv reply for request /tmp/dpdk/l2hi/mp_socket: 
> ipsec_mb_mp_msg
>
> This message corresponds exactly to the PID check in the code you 
> referenced:
> if (qp->qp_used_by_pid != req_param->process_id) {
>     CDEV_LOG_ERR("Unable to release qp_id=%d", qp_id);
>     goto out;
> }
>
> In our view, this log indicates an abnormal condition: a secondary 
> process should be able to release its own QPs without triggering an 
> error during normal shutdown.
>
> Thanks for your help.
>
> Best,
> Yang Ming


Hi Kai,

The queue pairs is shared between the primary and secondary processes. 
Even if each process calls rte_cryptodev_queue_pair_setup() with a 
unique qp_id, the primary and secondary still end up using the same 
shared queue pair structure, because cryptodev->data is shared between them.

 From the code path, cryptodev->data is allocated in the primary via 
rte_cryptodev_data_alloc() (inside 
ipsec_mb_create-->rte_cryptodev_pmd_create-->rte_cryptodev_pmd_allocate-->rte_cryptodev_data_alloc). 
This memory is placed in a shared memzone (rte_cryptodev_data_%u), so 
both primary and secondary processes reference the same cryptodev->data, 
including nb_queue_pairs and queue_pairs[].
As a result, when the secondary process exits, ipsec_mb_remove() is 
called (inside 
rte_eal_cleanup-->eal_bus_cleanup-->vdev_cleanup-->rte_vdev_driver-->ipsec_mb_remove-->ipsec_mb_qp_release-->ipsec_mb_secondary_qp_op) 
and it loops through all queue pairs using:
for (qp_id = 0; qp_id < cryptodev->data->nb_queue_pairs; qp_id++)
     ipsec_mb_qp_release(cryptodev, qp_id);

This causes the secondary to attempt releasing queue pairs it doesn't 
own, triggering the error logs mentioned in previous mail.

Best regards,
Yang Ming
--------------C5VT2WJSlL0swbHRaLsUawxr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>On 5/19/2025 6:46 PM, Ji, Kai wrote:</p>
    <blockquote type="cite"
cite="mid:DS0PR11MB74589B3EB4B98A5DE37AF748819CA@DS0PR11MB7458.namprd11.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <div class="elementToProof"
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
        Hi Yangming, </div>
      <div class="elementToProof"
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof"
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
        How did you configure the queue pairs differently between the
        primary and secondary processes?</div>
      <div class="elementToProof"
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof"
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
        The application must call rte_cryptodev_queue_pair_setup() with
        a unique qp_id for each process. This implies that each process
        should receive distinct queue pair configurations at runtime.
        From what I can tell, it’s likely that the secondary process is
        still using the same queue pair as the primary process.</div>
      <div class="elementToProof"
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof"
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
        Regards</div>
      <div class="elementToProof"
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof"
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
        Kai </div>
      <div class="elementToProof"
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof"
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div><br>
      </div>
      <div
style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <hr style="display: inline-block; width: 98%;">
      <div
style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <b>From:</b> Moses Young <a class="moz-txt-link-rfc2396E" href="mailto:mosesyyoung@gmail.com">&lt;mosesyyoung@gmail.com&gt;</a><br>
        <b>Sent:</b> Monday, May 12, 2025 11:10<br>
        <b>To:</b> Ji, Kai <a class="moz-txt-link-rfc2396E" href="mailto:kai.ji@intel.com">&lt;kai.ji@intel.com&gt;</a>; Yang Ming
        <a class="moz-txt-link-rfc2396E" href="mailto:ming.1.yang@nokia-sbell.com">&lt;ming.1.yang@nokia-sbell.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:dev@dpdk.org">dev@dpdk.org</a>
        <a class="moz-txt-link-rfc2396E" href="mailto:dev@dpdk.org">&lt;dev@dpdk.org&gt;</a><br>
        <b>Subject:</b> Re: [PATCH v2 2/2] crypto/ipsec_mb: fix QP
        release in secondary </div>
      <div
style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <p style="margin-top: 0px; margin-bottom: 0px;">On 5/7/2025 11:25
        PM, Ji, Kai wrote:</p>
      <blockquote>
        <div
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
          Hi Yangming, </div>
        <div
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div
style="line-height: 19px; font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
          PID check is implemented here:  </div>
        <div
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
          <a
href="https://github.com/DPDK/dpdk/blob/75f179ebe347b6098cf3af26d3d3b7168fe3fe24/drivers/crypto/ipsec_mb/ipsec_mb_ops.c#L376"
            id="OWAce7322dc-19fb-9a60-b9da-0cc56219bc49"
class="x_OWAAutoLink x_moz-txt-link-freetext moz-txt-link-freetext"
            data-auth="NotApplicable" moz-do-not-send="true">https://github.com/DPDK/dpdk/blob/75f179ebe347b6098cf3af26d3d3b7168fe3fe24/drivers/crypto/ipsec_mb/ipsec_mb_ops.c#L376</a></div>
        <div
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
          Can you share the steps to re-produce the error ?</div>
        <div
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
          Regards</div>
        <div
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
          Kai  </div>
        <div
style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <hr style="display: inline-block; width: 98%;">
        <div
style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <b>From:</b> Yang Ming<br>
          <b>Sent:</b> Thursday, April 24, 2025 15:26<br>
          <b>To:</b> <a href="mailto:dev@dpdk.org"
            id="OWAb157fb33-c271-4671-52d4-55ae7fc02603"
class="x_moz-txt-link-abbreviated OWAAutoLink moz-txt-link-freetext"
            moz-do-not-send="true">dev@dpdk.org</a><br>
          <b>Subject:</b> Re: [PATCH v2 2/2] crypto/ipsec_mb: fix QP
          release in secondary</div>
        <div
style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-size: 11pt;">Hi,<br>
          <br>
          On 2025/4/7 13:25, Yang Ming wrote:<br>
          &gt; From: myang <a href="mailto:ming.1.yang@nokia-sbell.com"
            id="OWA3f9efb88-ef9c-2a54-dceb-f658b1698fba"
            class="x_moz-txt-link-rfc2396E OWAAutoLink"
            moz-do-not-send="true">
            &lt;ming.1.yang@nokia-sbell.com&gt;</a><br>
          &gt;<br>
          &gt; When a secondary process tries to release a queue pair
          (QP) that<br>
          &gt; does not belong to it, error logs occur:<br>
          &gt; CRYPTODEV: ipsec_mb_ipc_request() line 373: Unable to
          release<br>
          &gt; qp_id=0<br>
          &gt; EAL: Message data is too long<br>
          &gt; EAL: Fail to handle message: ipsec_mb_mp_msg<br>
          &gt; EAL: Fail to recv reply for request
          /tmp/dpdk/l2hi/mp_socket:<br>
          &gt; ipsec_mb_mp_msg<br>
          &gt;<br>
          &gt; This patch ensures that a secondary process only frees a
          QP if<br>
          &gt; it actually owns it, preventing conflicts and resolving
          the<br>
          &gt; issue.<br>
          &gt;<br>
          &gt; Signed-off-by: myang <a
            href="mailto:ming.1.yang@nokia-sbell.com"
            id="OWAb2264f81-2e4b-4c96-ab14-a31b1a26ffdf"
            class="x_moz-txt-link-rfc2396E OWAAutoLink"
            moz-do-not-send="true">
            &lt;ming.1.yang@nokia-sbell.com&gt;</a><br>
          &gt; ---<br>
          &gt;   drivers/crypto/ipsec_mb/ipsec_mb_ops.c | 7 +++++--<br>
          &gt;   1 file changed, 5 insertions(+), 2 deletions(-)<br>
          &gt;<br>
          &gt; diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
          b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c<br>
          &gt; index 910efb1a97..50ee140ccd 100644<br>
          &gt; --- a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c<br>
          &gt; +++ b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c<br>
          &gt; @@ -138,6 +138,7 @@ int<br>
          &gt;   ipsec_mb_qp_release(struct rte_cryptodev *dev, uint16_t
          qp_id)<br>
          &gt;   {<br>
          &gt;        struct ipsec_mb_qp *qp =
          dev-&gt;data-&gt;queue_pairs[qp_id];<br>
          &gt; +     uint16_t process_id = (uint16_t)getpid();<br>
          &gt;  <br>
          &gt;        if (!qp)<br>
          &gt;                return 0;<br>
          &gt; @@ -152,8 +153,10 @@ ipsec_mb_qp_release(struct
          rte_cryptodev *dev, uint16_t qp_id)<br>
          &gt;                rte_free(qp);<br>
          &gt;                dev-&gt;data-&gt;queue_pairs[qp_id] =
          NULL;<br>
          &gt;        } else { /* secondary process */<br>
          &gt; -             return
          ipsec_mb_secondary_qp_op(dev-&gt;data-&gt;dev_id, qp_id,<br>
          &gt; -                                     NULL, 0,
          RTE_IPSEC_MB_MP_REQ_QP_FREE);<br>
          &gt; +             if (qp-&gt;qp_used_by_pid == process_id)<br>
          &gt; +                     return
          ipsec_mb_secondary_qp_op(dev-&gt;data-&gt;dev_id,<br>
          &gt; +                                             qp_id,
          NULL, 0,<br>
          &gt; +                                            
          RTE_IPSEC_MB_MP_REQ_QP_FREE);<br>
          &gt;        }<br>
          &gt;        return 0;<br>
          &gt;   }<br>
          <br>
          Hi Experts,<br>
          <br>
          Is there any chance to review and accept this patch?<br>
          <br>
          Brs,<br>
          <br>
          Yang Ming<br>
          <br>
        </div>
      </blockquote>
      <div>Hi,<br>
        <br>
        David. Thanks for your feedback. I will Cc maintainers in next
        version.<br>
        <br>
        Kai, Thanks for your feedback. Here's our test steps after
        applying the previous patch called "eal: prevent socket closure
        before MP sync" in this serious:<br>
        1. Start the primary process: Run the DPDK primary process with
        the IPsec MB crypto device.<br>
        2. Launch the secondary process: Start a DPDK secondary process
        using the same device parameters.<br>
        3. Exit the secondary normally.<br>
        <br>
        On secondary exit, error logs show below as my commit log's
        description:<br>
        CRYPTODEV: ipsec_mb_ipc_request() line 373: Unable to release
        qp_id=0<br>
        EAL: Message data is too long<br>
        EAL: Fail to handle message: ipsec_mb_mp_msg<br>
        EAL: Fail to recv reply for request /tmp/dpdk/l2hi/mp_socket:
        ipsec_mb_mp_msg<br>
        <br>
        This message corresponds exactly to the PID check in the code
        you referenced:<br>
        if (qp-&gt;qp_used_by_pid != req_param-&gt;process_id) {<br>
            CDEV_LOG_ERR("Unable to release qp_id=%d", qp_id);<br>
            goto out;<br>
        }<br>
        <br>
        In our view, this log indicates an abnormal condition: a
        secondary process should be able to release its own QPs without
        triggering an error during normal shutdown.<br>
        <br>
        Thanks for your help.<br>
        <br>
        Best,<br>
        Yang Ming</div>
    </blockquote>
    <p><br>
    </p>
    Hi Kai,<br>
    <br>
    The queue pairs is shared between the primary and secondary
    processes. Even if each process calls
    rte_cryptodev_queue_pair_setup() with a unique qp_id, the primary
    and secondary still end up using the same shared queue pair
    structure, because cryptodev-&gt;data is shared between them.<br>
    <br>
    From the code path, cryptodev-&gt;data is allocated in the primary
    via rte_cryptodev_data_alloc() (inside
ipsec_mb_create--&gt;rte_cryptodev_pmd_create--&gt;rte_cryptodev_pmd_allocate--&gt;rte_cryptodev_data_alloc).
    This memory is placed in a shared memzone (rte_cryptodev_data_%u),
    so both primary and secondary processes reference the same
    cryptodev-&gt;data, including nb_queue_pairs and queue_pairs[].<br>
    As a result, when the secondary process exits, ipsec_mb_remove() is
    called (inside
rte_eal_cleanup--&gt;eal_bus_cleanup--&gt;vdev_cleanup--&gt;rte_vdev_driver--&gt;ipsec_mb_remove--&gt;ipsec_mb_qp_release--&gt;ipsec_mb_secondary_qp_op)
    and it loops through all queue pairs using:<br>
    for (qp_id = 0; qp_id &lt; cryptodev-&gt;data-&gt;nb_queue_pairs;
    qp_id++)<br>
        ipsec_mb_qp_release(cryptodev, qp_id);<br>
    <br>
    This causes the secondary to attempt releasing queue pairs it
    doesn't own, triggering the error logs mentioned in previous mail.<br>
    <br>
    Best regards,<br>
    Yang Ming
  </body>
</html>

--------------C5VT2WJSlL0swbHRaLsUawxr--
