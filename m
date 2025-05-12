Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AE3C3ABBC
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 10:10:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35CD9402C9;
	Mon, 12 May 2025 12:10:37 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 550674025D
 for <dev@dpdk.org>; Mon, 12 May 2025 12:10:35 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b1ff9b276c2so2414697a12.1
 for <dev@dpdk.org>; Mon, 12 May 2025 03:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747044634; x=1747649434; darn=dpdk.org;
 h=in-reply-to:from:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=XPyJ6o3OXpys9hf967nLzC11+wK2eMIoU5aWrum7yco=;
 b=Q2RpPDXLDHrN6/t6g3/bzTHvq5Y+O6KrgQAF2z0ACRjFr3i3pFfNdiqb9smY55E9UK
 wk1QrDj/P79SJypCdBamX+mAHJinAVSXEKsSB75OIghMLakbrK6eq/HMJVkX69qcsEgK
 sAYG+wAcxqcRRcdi4onIKRXNXUWG8WvqltBGASgnuqSKhyS8NJ1yPbP5xa66q3XZOnNT
 EQAb6GHPWkcQ07kJppG4HqvfdpLWvsg2DftbNw3xqCTT6edHv4KlSSiSLfXz5SGDvFEf
 XhPFW5zvi4Cxz4D/++iFgRGNUxdxFmnWMcWLb8SV7/0aGESlWchTfqTkqjD1CUPOED73
 3MBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747044634; x=1747649434;
 h=in-reply-to:from:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XPyJ6o3OXpys9hf967nLzC11+wK2eMIoU5aWrum7yco=;
 b=f8pwe9rRbk/0BZgAZj8rJoUbat84tq3UspGsrD4IiNl14o1pu6nJFHdtHVzpzyVCL/
 Jy9GXLu0VMr5BS5u2GvlOkDnuFQOis7xbWyz/ycp1PuHUO36jQ/9LSbEVnT+GYFNKtn8
 CR5nsWNF9tA96DWOWpxR0cW7JAc0b9BTu2elZNIZG7CHUrPnKpJKDvgKszQkvNFOXRLH
 3oRPvcLD+B0k8PF9OAtWCLHYiDwps7kJAGPzurukx0LoS2lFu7PxYjf+FCG9kDkcpXgw
 Vz9lajWx504BzRbSp6urAz5f5bUb/6BgIw23DP9g8Z6WpZPQH/1VFieFRXFJzWViIpRT
 4uLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF+BTKTXwGt2MnT+4CWUrLgTQZDoJr5GqICDdvH2rIHniwCvMZ2C5igKikMFqHEkSPBLw=@dpdk.org
X-Gm-Message-State: AOJu0YyVaLMnUU8bdJADk2YcWyYkOg1fhvGGug/fw1Udazw5++fmOCn2
 8mie7MYVWcVqkzCLnR9dkUNw6alZ1MDDn0PA5lLQ/wK+vRzQXWGeWHKjfSXF
X-Gm-Gg: ASbGncutUM+TkpliM5Ddpwd1CDM9kJX+mvXmdhPqlakeo9ElpUiVvcC3nkcdydUJ0Bf
 CimEi/fzFJEdAR8L/GQPZe340oNi4v4dFmXYz+n3krLTTr2TCSsgdA/XSX10ShLJH0U6UCgd5q9
 0r+KXg8/LioqiYcgHEqNYyi5G8BXKhclyPdD9aeXY4Uw6ZGYQQalERQxKDsxP2dayNSee20fC/5
 nYyyk6xZ5gqY+LrQyswZxFfcxZ7N9uEfhnokxBGv8wfK0qBnN9ME0SfleCRYEXWVzKdCRwvmaee
 aDvv+b6/MTT64AqljWVwFk3gEhzyrpjKIZPJGY4OYE40bzh1ELLbwl0obxZ751+tgsUbNTVPJeo
 0
X-Google-Smtp-Source: AGHT+IH4cA9ZOWWtoVnRU1jJ6+IN2rSoFVOGjrjzX6TljnzaXtJlqsdUx9H8KEtuVYm88M7Ray9iEw==
X-Received: by 2002:a17:902:fc4e:b0:21a:8300:b9d5 with SMTP id
 d9443c01a7336-22fc8b59787mr202594555ad.23.1747044634004; 
 Mon, 12 May 2025 03:10:34 -0700 (PDT)
Received: from [192.168.31.141] ([183.134.173.124])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc8271a7dsm59910545ad.153.2025.05.12.03.10.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 03:10:33 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------3d2Pn3ROE9VDOvoipafQBt1v"
Message-ID: <7cf98921-1ca2-4707-a0fd-609c1d2cce65@gmail.com>
Date: Mon, 12 May 2025 18:10:30 +0800
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
From: Moses Young <mosesyyoung@gmail.com>
In-Reply-To: <DS0PR11MB74583A392F4BEEB1E2AC9F2E8188A@DS0PR11MB7458.namprd11.prod.outlook.com>
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
--------------3d2Pn3ROE9VDOvoipafQBt1v
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/7/2025 11:25 PM, Ji, Kai wrote:

> Hi Yangming,
>
> PID check is implemented here:
> https://github.com/DPDK/dpdk/blob/75f179ebe347b6098cf3af26d3d3b7168fe3fe24/drivers/crypto/ipsec_mb/ipsec_mb_ops.c#L376 
> <https://github.com/DPDK/dpdk/blob/75f179ebe347b6098cf3af26d3d3b7168fe3fe24/drivers/crypto/ipsec_mb/ipsec_mb_ops.c#L376>
>
> Can you share the steps to re-produce the error ?
>
> Regards
>
> Kai
>
> ------------------------------------------------------------------------
> *From:* Yang Ming
> *Sent:* Thursday, April 24, 2025 15:26
> *To:* dev@dpdk.org
> *Subject:* Re: [PATCH v2 2/2] crypto/ipsec_mb: fix QP release in 
> secondary
>
> Hi,
>
> On 2025/4/7 13:25, Yang Ming wrote:
> > From: myang <ming.1.yang@nokia-sbell.com>
> >
> > When a secondary process tries to release a queue pair (QP) that
> > does not belong to it, error logs occur:
> > CRYPTODEV: ipsec_mb_ipc_request() line 373: Unable to release
> > qp_id=0
> > EAL: Message data is too long
> > EAL: Fail to handle message: ipsec_mb_mp_msg
> > EAL: Fail to recv reply for request /tmp/dpdk/l2hi/mp_socket:
> > ipsec_mb_mp_msg
> >
> > This patch ensures that a secondary process only frees a QP if
> > it actually owns it, preventing conflicts and resolving the
> > issue.
> >
> > Signed-off-by: myang <ming.1.yang@nokia-sbell.com>
> > ---
> >   drivers/crypto/ipsec_mb/ipsec_mb_ops.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c 
> b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
> > index 910efb1a97..50ee140ccd 100644
> > --- a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
> > +++ b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
> > @@ -138,6 +138,7 @@ int
> >   ipsec_mb_qp_release(struct rte_cryptodev *dev, uint16_t qp_id)
> >   {
> >        struct ipsec_mb_qp *qp = dev->data->queue_pairs[qp_id];
> > +     uint16_t process_id = (uint16_t)getpid();
> >
> >        if (!qp)
> >                return 0;
> > @@ -152,8 +153,10 @@ ipsec_mb_qp_release(struct rte_cryptodev *dev, 
> uint16_t qp_id)
> >                rte_free(qp);
> >                dev->data->queue_pairs[qp_id] = NULL;
> >        } else { /* secondary process */
> > -             return ipsec_mb_secondary_qp_op(dev->data->dev_id, qp_id,
> > -                                     NULL, 0, 
> RTE_IPSEC_MB_MP_REQ_QP_FREE);
> > +             if (qp->qp_used_by_pid == process_id)
> > +                     return ipsec_mb_secondary_qp_op(dev->data->dev_id,
> > +                                             qp_id, NULL, 0,
> > + RTE_IPSEC_MB_MP_REQ_QP_FREE);
> >        }
> >        return 0;
> >   }
>
> Hi Experts,
>
> Is there any chance to review and accept this patch?
>
> Brs,
>
> Yang Ming
>
Hi,

David. Thanks for your feedback. I will Cc maintainers in next version.

Kai, Thanks for your feedback. Here's our test steps after applying the 
previous patch called "eal: prevent socket closure before MP sync" in 
this serious:
1. Start the primary process: Run the DPDK primary process with the 
IPsec MB crypto device.
2. Launch the secondary process: Start a DPDK secondary process using 
the same device parameters.
3. Exit the secondary normally.

On secondary exit, error logs show below as my commit log's description:
CRYPTODEV: ipsec_mb_ipc_request() line 373: Unable to release qp_id=0
EAL: Message data is too long
EAL: Fail to handle message: ipsec_mb_mp_msg
EAL: Fail to recv reply for request /tmp/dpdk/l2hi/mp_socket: 
ipsec_mb_mp_msg

This message corresponds exactly to the PID check in the code you 
referenced:
if (qp->qp_used_by_pid != req_param->process_id) {
     CDEV_LOG_ERR("Unable to release qp_id=%d", qp_id);
     goto out;
}

In our view, this log indicates an abnormal condition: a secondary 
process should be able to release its own QPs without triggering an 
error during normal shutdown.

Thanks for your help.

Best,
Yang Ming
--------------3d2Pn3ROE9VDOvoipafQBt1v
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>On 5/7/2025 11:25 PM, Ji, Kai wrote:</p>
    <blockquote type="cite"
cite="mid:DS0PR11MB74583A392F4BEEB1E2AC9F2E8188A@DS0PR11MB7458.namprd11.prod.outlook.com">
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
style="line-height: 19px; font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
        PID check is implemented here:  </div>
      <div class="elementToProof"
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
        <a
href="https://github.com/DPDK/dpdk/blob/75f179ebe347b6098cf3af26d3d3b7168fe3fe24/drivers/crypto/ipsec_mb/ipsec_mb_ops.c#L376"
          id="OWAe6661da6-9642-8ce3-0501-07105371936c"
          class="OWAAutoLink moz-txt-link-freetext"
          moz-do-not-send="true">https://github.com/DPDK/dpdk/blob/75f179ebe347b6098cf3af26d3d3b7168fe3fe24/drivers/crypto/ipsec_mb/ipsec_mb_ops.c#L376</a></div>
      <div class="elementToProof"
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof"
style="font-family: &quot;IntelOne Text&quot;; font-size: 10pt; color: rgb(0, 0, 0);">
        Can you share the steps to re-produce the error ?</div>
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
        <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:dev@dpdk.org">dev@dpdk.org</a><br>
        <b>Subject:</b> Re: [PATCH v2 2/2] crypto/ipsec_mb: fix QP
        release in secondary </div>
      <div
style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="font-size: 11pt;">Hi,<br>
        <br>
        On 2025/4/7 13:25, Yang Ming wrote:<br>
        &gt; From: myang <a class="moz-txt-link-rfc2396E" href="mailto:ming.1.yang@nokia-sbell.com">&lt;ming.1.yang@nokia-sbell.com&gt;</a><br>
        &gt;<br>
        &gt; When a secondary process tries to release a queue pair (QP)
        that<br>
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
        &gt; This patch ensures that a secondary process only frees a QP
        if<br>
        &gt; it actually owns it, preventing conflicts and resolving the<br>
        &gt; issue.<br>
        &gt;<br>
        &gt; Signed-off-by: myang <a class="moz-txt-link-rfc2396E" href="mailto:ming.1.yang@nokia-sbell.com">&lt;ming.1.yang@nokia-sbell.com&gt;</a><br>
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
        &gt;                dev-&gt;data-&gt;queue_pairs[qp_id] = NULL;<br>
        &gt;        } else { /* secondary process */<br>
        &gt; -             return
        ipsec_mb_secondary_qp_op(dev-&gt;data-&gt;dev_id, qp_id,<br>
        &gt; -                                     NULL, 0,
        RTE_IPSEC_MB_MP_REQ_QP_FREE);<br>
        &gt; +             if (qp-&gt;qp_used_by_pid == process_id)<br>
        &gt; +                     return
        ipsec_mb_secondary_qp_op(dev-&gt;data-&gt;dev_id,<br>
        &gt; +                                             qp_id, NULL,
        0,<br>
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
    Hi,<br>
    <br>
    David. Thanks for your feedback. I will Cc maintainers in next
    version.<br>
    <br>
    Kai, Thanks for your feedback. Here's our test steps after applying
    the previous patch called "eal: prevent socket closure before MP
    sync" in this serious:<br>
    1. Start the primary process: Run the DPDK primary process with the
    IPsec MB crypto device.<br>
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
    This message corresponds exactly to the PID check in the code you
    referenced:<br>
    if (qp-&gt;qp_used_by_pid != req_param-&gt;process_id) {<br>
        CDEV_LOG_ERR("Unable to release qp_id=%d", qp_id);<br>
        goto out;<br>
    }<br>
    <br>
    In our view, this log indicates an abnormal condition: a secondary
    process should be able to release its own QPs without triggering an
    error during normal shutdown.<br>
    <br>
    Thanks for your help.<br>
    <br>
    Best,<br>
    Yang Ming
  </body>
</html>

--------------3d2Pn3ROE9VDOvoipafQBt1v--
