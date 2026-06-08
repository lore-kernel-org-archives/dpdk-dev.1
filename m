Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C95ECD8C92
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 15:49:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66D7740670;
	Mon,  8 Jun 2026 17:49:49 +0200 (CEST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id 2BFA5402DD
 for <dev@dpdk.org>; Mon,  8 Jun 2026 17:49:48 +0200 (CEST)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-517863a2edfso35788101cf.1
 for <dev@dpdk.org>; Mon, 08 Jun 2026 08:49:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780933787; cv=none;
 d=google.com; s=arc-20240605;
 b=SIOhDaLsQnD6VfAP7+tUI4MB0x7nzu6Oe5aOy3B9cMF+xOEETn+/q6JuHBYe7juRaW
 RiGSkkX5xgArto+UuQnaofmG4KCafxXRK7OiSIqllM+MeM3TJ0keA1qrUcLUs6vO6/aQ
 Qeae1JSN01c8BWOCGCtwTg0IqPi8FjK87eG5NOlzLIMRFXuClaWkHe5QCIO1X2qbXKuD
 iqpBoD7YnKL3K7DvUhZci7M3c6CYm7g6ntl+gMNuqWQYDFUquOCb1dqWy5pcEFIHokL6
 voG2g7CauPUwGRw6KgEn/e6U3ZRof53hx0yf1ES3TiOZphR+pvIOFm+g5cKcRm2Ej/wI
 BeSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LQKkMzfW4ILTsiIA+SER/eLzbpAJJ1VdnUVk6IKdyTY=;
 fh=EWMbXYxloiF25UKa3+132FbIkngNc9Ix7z+odAXt93c=;
 b=MWDrAixmLvZxNI/RtbvYVcfKCRlZLkF8zvbETyYhRYvX+JMOGabiz+kIo/UfPdds4+
 rWOZOxbvrTgMhfzZGyJOj3FsIlTV6pjimUNYCCd0/QwktQ3ozwD//UlXbTOsN9MGmdcv
 yixCppSddmIJdyd0rV5BGS20V5LgadPqkUFbpcWY7evedsJ1Tyvv2q9BKOzkelIqyNVE
 bUzLGXaCaITew26NNj+sPKRvv5C49Z/SCrm17KTujKrUaXR7K+DRdF/JL9wzqKiaZZv8
 fYwEnK2n1y/+74sw2+zXfXMcyWFqZ7/jLLgwVSA/zIV7I34F8avl5iWPoPKeHeEbZXCG
 GdIQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780933787; x=1781538587; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQKkMzfW4ILTsiIA+SER/eLzbpAJJ1VdnUVk6IKdyTY=;
 b=XUDKAa8y7Aj1SGD8zajgyI0GmA3L80bWFgFZglFTJ/+pSjUCLHBkONbdZufoIyNXEs
 mzstPq8roxb9aB6ldbe6qU20ioP3VbM1Jx8uFbxl4Ra5nn/BPWHnei6/SEULr9jbSWsq
 ZjjqH818M1jhtq9xm/yaUXksgIfV9nIrNoa2XyozCit2ySQ7kpjmHE0OJD+iqAkl9/yF
 qejlJwwfDKaDCK8ipm6703wwm+m5WkAfwB7xzoVz0yrLORaCSx3h627oVs/Ay/dfYeJt
 Wo7FGxjv9mzoE0ZroYJc31lPgK5D1oVv8tW1OpQFLHiH1d0AAZytpbJxGfwrhKXfvKDD
 vQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780933787; x=1781538587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LQKkMzfW4ILTsiIA+SER/eLzbpAJJ1VdnUVk6IKdyTY=;
 b=hvUQ9mnkwM9ZLfM8IrZX1CULp9FDxM/uu5zD/wc9mUc91vyg6w/tqaeDfLnzV/iiM0
 Us7zT0IsOB795RVQ/bPSKzqJFqXK1Er3EBVn8h1bbKYpVB75zrJ7ijpl7Lmvy21JRx82
 8tv1JIRjQuqn495f98F/5Ewov4YA5ajGNnNEjsJ01sQqI17Ddv4l+cCwA61aLy36LqO6
 V/c+VV+xosqOYtuoaIjhCc8aYQGmTVFdc6yJJxbjc0CiwlPHL+ES5uSE1aHmF2yY0pm2
 x/QBLa7VFzBibjhrDt5DsOoahQbqzmp12Dc9choo5DqFfuP0E28K1pBqWDBw1o2PcjCT
 FIZA==
X-Gm-Message-State: AOJu0YwpfCWT9tJw4krYkwYe6UQPVn2tx7tZe1c3yOVOrsf8ULl0hq87
 J+BsFxvKbZ1+ASw6Wz2ZRqAP9FLgy1nV6Wc5NVKEEFkSeeeFOI1JFAlXnAg4NRp8tH5GHtx9r7r
 aZdE+aSLx7Ha9uFShhtVJMz02rEk43Q4=
X-Gm-Gg: Acq92OFBwcCxgjfqRu2wDzFomn30CnB/u84GkzeYgvRHPdA3FPXOyIp/sMdXEaGxwSE
 k7SdcCeVPBx8jbJjMyQVebQ1vAUUlNNVpX8ZqBSDGFINsWBYMMiVl1wECiuvlrSDTdt3zn8d5BM
 qIXKQTQ6F/vmylDCnfEhCj8bbN1J1Nd12zzL115DcMneQDo8BAaswDpE7upI/WAys38RM3N8WNr
 6B/yJQYfswdfm5WQemQ2hQl4abLR6oTI/CjN3wmwW26FmJw6zMLfy7uz7nRocz0LilSa32s8r+L
 u8ziyMlxbb6etQ==
X-Received: by 2002:ac8:5814:0:b0:517:8da1:4d3 with SMTP id
 d75a77b69052e-51795afdceamr226984731cf.22.1780933787268; Mon, 08 Jun 2026
 08:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260121180845.889190-1-stephen@networkplumber.org>
 <20260413164652.33291-1-stephen@networkplumber.org>
 <20260413164652.33291-3-stephen@networkplumber.org>
In-Reply-To: <20260413164652.33291-3-stephen@networkplumber.org>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 8 Jun 2026 21:19:20 +0530
X-Gm-Features: AVVi8Cc5rsVLe7S7-1Mf32WGLhohvbG-vq01WljiTSkoipxN3KcE_qAR4MI2Suw
Message-ID: <CALBAE1PzEtyBzKiKaU83q0OtwRwaCTmqDETsc5NNODDQ9hzauw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] event/cnxk: add pause to spinloops
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Pavan Nikhilesh <pbhagavatula@marvell.com>, 
 Shijith Thotton <sthotton@marvell.com>
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

On Mon, Apr 13, 2026 at 10:36=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On SMT systems when a spinloop is done without a pause
> it may cause excessive latency. This problem was found
> by the fix_empty_spinloops coccinelle script.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

rte_pause() translates to YIELD instruction. Since cnxk is an
integrated SoC and it is a single threaded core, it won't help on
anything other than adding one instruction bit more latency.
In general 3/3 devtool is good. Please send a it separate version so
that 3/3 patches can be merged through the main tree.



---------------
The YIELD instruction write up from ARMv8 manual.

YIELD is a hint instruction in the ARMv8-A architecture. It tells the
CPU that the current hardware thread is doing nothing useful right now
(typically spinning in a busy-wait loop), so the processor may
reallocate shared execution resources to other hardware threads.

On SMT (multithreaded) cores, this can give sibling hardware threads
more resources, improving overall throughput.
On most current single-threaded ARM cores, YIELD executes as a NOP =E2=80=
=94
it has no microarchitectural effect, but it's architecturally valid
and harmless. It does not put the core to sleep (unlike WFE/WFI).
It's a pure hint: it never changes program correctness, only
potentially performance/fairness.
-------------
