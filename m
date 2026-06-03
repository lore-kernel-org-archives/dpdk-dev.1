Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67EECD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 03:57:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C764A402BD;
	Wed,  3 Jun 2026 05:57:05 +0200 (CEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id F16F2402BD
 for <dev@dpdk.org>; Wed,  3 Jun 2026 05:57:04 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-460166910e6so1416844f8f.2
 for <dev@dpdk.org>; Tue, 02 Jun 2026 20:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780459024; x=1781063824; darn=dpdk.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hKBIHop4Mh95Z5sxPbEy3L5Nb8O6oiKEnFZ9bWe3l5A=;
 b=EULKBOW11RXMFjo/gBktb4RSC8hUKydO5OncZbEQg5iIRXwy9p4RvmlEko3LufiQ6M
 5TjnDE22q7WuUqLzuXZEulzrCkpRE9NxEly2mIR7JFmKZyEY5MvLRjw9HPnJdHLRkxDQ
 OhkJYSJEOUqOCk1xIvjZIdvJkZb2EC2IoK+KavDLs9hpqJtlaATRxlbgb33ecXBWJRmd
 neBgv6RY0edEKUiI74R5Tw74DjGb4TbD2kxnjzYnDkJixcTipPNtGVTdug5oCx2/EHTW
 1TEN7RtKX9gv68UKZnUuFA5RsHcRaUlGA0zoPRF2KxPfDm1WFoiGbLgn1mTsaxHOY7zF
 90Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780459024; x=1781063824;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hKBIHop4Mh95Z5sxPbEy3L5Nb8O6oiKEnFZ9bWe3l5A=;
 b=ppdHtydpWF4SAfE/3FXsFH3gL/8uRrMOac9vSMOUjmh8Q4LIlz3PB1YuHXxqT1tLYK
 pS7x0LKpdRRISjlZ7d9xJsfVqpxhNrmdEmcViWhLZrJdUljATGtOe4/8W5U2zJapRr+T
 HP8dWGnSh/et6hzFJil1FMD5GATr9J8w8KSikt5XQBqoVotnJvp/ftxhY+7tTjIcyF1W
 CeZ0ssbDIpbnpkpr4sQ+55CIC7mROQBFnFN5gGiPp4d63xC0WbIAyvcNViiUHN7Z6W23
 GwD4CaPs0OQuVhkqTRNb9UjMJvLEr4E5/oZVRhZD2YuEsrj6/xvnxhSGX66GFHSe4G+l
 WN0A==
X-Gm-Message-State: AOJu0Yw5spkcVwvD7bUrf6hxjr0MZazHSiNG6iQwVFWHcfu+XlX5OOp/
 I6aT8re0toSARsuLnywxmH5aTFISrdOXfPEkjxhPnAOB9Qkf5RvJ6kVI
X-Gm-Gg: Acq92OFNWK0hvzcjy+m5GCfSkNh5Q34ZFT+pOCJqRsnGudSX1Q8kuiWNNM6uWxiqHOe
 dYA28KYZOHJPZq31wH9vapmy+WIJYjFFCgI2SF+b1Fh5E4XycEfqFmTnCcPK2KP2ch73jmxi4US
 i1XAiQrZB8i+67pkrQRvndZC9r8e/gHofEXrHfS9/MGAPh5oYYueg5ylAsEu7io4GtStpgrzrOG
 FKvkbwdzBj9aaqWupN1gFYDEl1KbWMjVwMqW6IonweYzeQbFPnYrcwYrELm/awAFrn6CbDDxrtB
 YXtrFghO6eQYkkYlfXrglyAVWCCFWGemJ8/f3I/AFYqQ1JXK4e6F37DjfX63woiS3J0Jdrn5MZq
 lgvMMM0JFXYTsJ2yFGaWD5bXcSQx/OHKLGv7Lt8a80YRlkQt4Q7wvjGZJDNITBv1rMbxkaOnNfB
 UJaiKMswv7JBSv68C38h9uO7tx7bax0DPYrnAzlDhomluupI+vDgJhvLMdfq8FKWE=
X-Received: by 2002:adf:fb85:0:b0:45e:fa38:c899 with SMTP id
 ffacd0b85a97d-46021783cecmr1253802f8f.4.1780459024330; 
 Tue, 02 Jun 2026 20:57:04 -0700 (PDT)
Received: from [10.8.0.6] ([185.229.111.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f360bd6sm4362123f8f.36.2026.06.02.20.57.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 20:57:04 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------xYKm7trA9I4IRNZ50gQAidG7"
Message-ID: <a53fce43-d572-4f93-bd8f-1d38fd08a229@gmail.com>
Date: Wed, 3 Jun 2026 06:57:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net/bnxt/tf_core: fix ignored return of EM delete
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Cc: dev@dpdk.org, ajit.khaparde@broadcom.com, stable@dpdk.org
References: <20260519044344.9544-1-denserg.edu@gmail.com>
 <20260519044344.9544-2-denserg.edu@gmail.com>
 <CA+BST0nKjhifTBgKgn7qjb2oGEb7XFq3Ejr75u0T9Lm_c0p1EQ@mail.gmail.com>
Content-Language: en-US
From: Denis Sergeev <denserg.edu@gmail.com>
In-Reply-To: <CA+BST0nKjhifTBgKgn7qjb2oGEb7XFq3Ejr75u0T9Lm_c0p1EQ@mail.gmail.com>
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
--------------xYKm7trA9I4IRNZ50gQAidG7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/20/26 12:02 AM, Kishore Padmanabha wrote:
>
> On Tue, May 19, 2026 at 12:44 AM Denis Sergeev <denserg.edu@gmail.com> 
> wrote:
>
>     The return value of tfc_em_delete_raw() in tfc_em_delete() was
>     silently discarded: rc was unconditionally overwritten by the
>     subsequent tfc_cpm_get_cmm_inst() call without any error check.
>
>     If tfc_em_delete_raw() fails, the HW EM entry is not removed but
>     the function continues to free the corresponding SW pool entry,
>     creating a HW/SW state inconsistency that can lead to stale flow
>     matches or incorrect pool slot reuse.
>
>     Add an error check after the call and return -EINVAL on failure.
>
>     Found by Linux Verification Center (linuxtesting.org
>     <http://linuxtesting.org>) with SVACE.
>
>     Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
>     Cc: stable@dpdk.org
>
>     Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
>     ---
>      drivers/net/bnxt/tf_core/v3/tfc_em.c | 5 +++++
>      1 file changed, 5 insertions(+)
>
>     diff --git a/drivers/net/bnxt/tf_core/v3/tfc_em.c
>     b/drivers/net/bnxt/tf_core/v3/tfc_em.c
>     index 3fe4dbe3fe..4c126dc2f4 100644
>     --- a/drivers/net/bnxt/tf_core/v3/tfc_em.c
>     +++ b/drivers/net/bnxt/tf_core/v3/tfc_em.c
>     @@ -661,6 +661,11 @@ int tfc_em_delete(struct tfc *tfcp, struct
>     tfc_em_delete_parms *parms)
>                                    &db_offset
>      #endif
>                                    );
>     +       if (rc != 0) {
>     +               PMD_DRV_LOG_LINE(ERR, "tfc_em_delete_raw() failed:
>     %s",
>     +                                strerror(-rc));
>     +               return -EINVAL;
>     +       }
>
>             record_offset = REMOVE_POOL_FROM_OFFSET(pi.lkup_pool_sz_exp,
>     record_offset);
>
> This change is not required, even if deletion of the HW entry fails, 
> it should continue to delete the SW state, since at the end all the HW 
> entries are invalidated. Have you been able to reproduce a scenario 
> where this failure is seen.
>
>     -- 
>     2.50.1
>
Thanks for the review. I'll drop this patch.

The issue was flagged by a static analyzer that caught the discarded
return value of tfc_em_delete_raw(). Over the past week I tried to
reproduce an actual failure at runtime, but I couldn't. So it seems
this failure doesn't occur in real runtime.

-- 
Best regards,
Denis Sergeev

--------------xYKm7trA9I4IRNZ50gQAidG7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 5/20/26 12:02 AM, Kishore Padmanabha
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CA+BST0nKjhifTBgKgn7qjb2oGEb7XFq3Ejr75u0T9Lm_c0p1EQ@mail.gmail.com"><br>
      <div class="gmail_quote gmail_quote_container">
        <div dir="ltr" class="gmail_attr">On Tue, May 19, 2026 at
          12:44 AM Denis Sergeev &lt;<a
            href="mailto:denserg.edu@gmail.com"
            class="moz-txt-link-freetext">denserg.edu@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The
          return value of tfc_em_delete_raw() in tfc_em_delete() was<br>
          silently discarded: rc was unconditionally overwritten by the<br>
          subsequent tfc_cpm_get_cmm_inst() call without any error
          check.<br>
          <br>
          If tfc_em_delete_raw() fails, the HW EM entry is not removed
          but<br>
          the function continues to free the corresponding SW pool
          entry,<br>
          creating a HW/SW state inconsistency that can lead to stale
          flow<br>
          matches or incorrect pool slot reuse.<br>
          <br>
          Add an error check after the call and return -EINVAL on
          failure.<br>
          <br>
          Found by Linux Verification Center (<a
            href="http://linuxtesting.org" rel="noreferrer"
            target="_blank">linuxtesting.org</a>) with SVACE.<br>
          <br>
          Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")<br>
          Cc: <a href="mailto:stable@dpdk.org" target="_blank"
            class="moz-txt-link-freetext">stable@dpdk.org</a><br>
          <br>
          Signed-off-by: Denis Sergeev &lt;<a
            href="mailto:denserg.edu@gmail.com" target="_blank"
            class="moz-txt-link-freetext">denserg.edu@gmail.com</a>&gt;<br>
          ---<br>
           drivers/net/bnxt/tf_core/v3/tfc_em.c | 5 +++++<br>
           1 file changed, 5 insertions(+)<br>
          <br>
          diff --git a/drivers/net/bnxt/tf_core/v3/tfc_em.c
          b/drivers/net/bnxt/tf_core/v3/tfc_em.c<br>
          index 3fe4dbe3fe..4c126dc2f4 100644<br>
          --- a/drivers/net/bnxt/tf_core/v3/tfc_em.c<br>
          +++ b/drivers/net/bnxt/tf_core/v3/tfc_em.c<br>
          @@ -661,6 +661,11 @@ int tfc_em_delete(struct tfc *tfcp,
          struct tfc_em_delete_parms *parms)<br>
                                         &amp;db_offset<br>
           #endif<br>
                                         );<br>
          +       if (rc != 0) {<br>
          +               PMD_DRV_LOG_LINE(ERR, "tfc_em_delete_raw()
          failed: %s",<br>
          +                                strerror(-rc));<br>
          +               return -EINVAL;<br>
          +       }<br>
          <br>
                  record_offset =
          REMOVE_POOL_FROM_OFFSET(pi.lkup_pool_sz_exp,<br>
                                                         
          record_offset);<br>
        </blockquote>
        <div>This change is not required, even if deletion of the HW
          entry fails, it should continue to delete the SW state, since
          at the end all the HW entries are invalidated. Have you been
          able to reproduce a scenario where this failure is seen. </div>
        <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">--
          <br>
          2.50.1</blockquote>
      </div>
    </blockquote>
    <p
class="font-claude-response-body break-words whitespace-normal leading-[1.7]">Thanks
      for the review. I'll drop this patch.</p>
    <p
class="font-claude-response-body break-words whitespace-normal leading-[1.7]">The
      issue was flagged by a static analyzer that caught the discarded<br>
      return value of tfc_em_delete_raw(). Over the past week I tried to<br>
      reproduce an actual failure at runtime, but I couldn't. So it
      seems<br>
      this failure doesn't occur in real runtime.</p>
    <pre class="moz-signature" cols="72">-- 
Best regards,
Denis Sergeev</pre>
  </body>
</html>

--------------xYKm7trA9I4IRNZ50gQAidG7--
