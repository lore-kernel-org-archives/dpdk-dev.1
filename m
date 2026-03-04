Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F559EDEC01
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 02:03:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCA6B402CC;
	Wed,  4 Mar 2026 03:03:19 +0100 (CET)
Received: from mail-dl1-f98.google.com (mail-dl1-f98.google.com [74.125.82.98])
 by mails.dpdk.org (Postfix) with ESMTP id E205C40269
 for <dev@dpdk.org>; Wed,  4 Mar 2026 03:03:17 +0100 (CET)
Received: by mail-dl1-f98.google.com with SMTP id
 a92af1059eb24-127423bea4bso877856c88.0
 for <dev@dpdk.org>; Tue, 03 Mar 2026 18:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772589797; x=1773194597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L16ZX0NyxLaqH0LP9TK/fDXUsxQDPhFmtvD9FKS3ePk=;
 b=YnReHCHal7ACoRLBVXjxau2JxaQ3sLHjgCJHXqWPwT9a+mx/X8J3fz/9Ja6CLX40c0
 qhbGZVRTnkaUJptHdLdShvaCJIFUnz5GzpjsEWpjN4j/fx9ptnvVhbDVFPyFUuSmHfsZ
 uxjelbpxPPI4WirFBMHMR5PiUvnt82iMcElJarlkwn5qJh9on8auy+nJEeDrIdloku0E
 aa+7YwvsyyROxZMqs2zee3N9nFe+l45TozSr1YeqDPuXYvDZOGlqMwJ5M4qFI7yxmW9y
 OR5YFi2f/VEkQ955igR6yvGQehVvJOF5cFiZgO4uKUa4o0Ih3FRXtZ55Kl6TpnLBlTLR
 5G4Q==
X-Forwarded-Encrypted: i=2;
 AJvYcCVSuQ0Ri3GFD4aC70SkWUk7UgX2GN3TA9vxID22MjKDAZJ2IvdHHdW+NGw5D4iIcSj5eQU=@dpdk.org
X-Gm-Message-State: AOJu0YxVg16WMP8mwf+B6lZhnBd+vV53NVMExJd1xS57eb+vRdMYl6NJ
 i8bB1H01RR+Cg+ZU9ohg9aLhSPVn3SxRL8H0OAp/Y4q6G/JqpMQE6bekoe6b66+VByKpsqIGMFZ
 vfopqK82SJAS6sGarJhHi62IuBnVsfR0ajULv4CLG85IO8mEYT0NULTIiK331FAgEfvoTPXGR9d
 M7XKKNhn2FzPpD4Fzx+OBmbQW8xo1jgLBppY8D5/CjZ4nrGYdcVd7Yhrv1FIQgBeA05ALAOm1WY
 HFjlQ==
X-Gm-Gg: ATEYQzyWtJgjXA/BQDTUmU5a22Rc0tGg/Hju9w7eDABgWD9E+08CDYyHHoZW2X9LHcA
 yl3zmUJmjmTgIhHGOLGoa4FZHWkYb5GAm8QawTvz6gGiekIYS7n7Ffq9inD/Feo3ZhIEGceXsbI
 +3CDrXq3vT9WPRAqABlhxcATx29X7ivhPIEgyxUCeZGS65yFyZudwXFpnTGQKNV7N21lBvBK1Fa
 B7fAN7uLI6DYlnyaTkW+K2t6ePoksepKRJjhnZmZBJINDMkZRZ7+SfYEjpDuMoJi1iy45qtoRWu
 PyWt0CsyBBriwWm1kYlM16NlFX8uDmAqlRgJUGh+5sek0UWZCl/FRDxhTY/4wba3V35gHkUrwUm
 VjHdeHOQweRnxsW7vbCEVrPsDst5rA2cgBCMl032HqpHnGauJHOuia475kXG92tNAaWxmFYKCQq
 w/wqj43s3GW1nG1JUMD9rHD8BrODmpfJC+t+awI4Zhci6eB7EspILXaOUD6yLOjds+3Dg=
X-Received: by 2002:a05:7022:6712:b0:11b:ca88:c4f7 with SMTP id
 a92af1059eb24-128b70ec898mr168637c88.40.1772589796266; 
 Tue, 03 Mar 2026 18:03:16 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-2be29f1a2d2sm281977eec.8.2026.03.03.18.03.15
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Mar 2026 18:03:16 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-660a92c7ef0so1525493a12.1
 for <dev@dpdk.org>; Tue, 03 Mar 2026 18:03:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772589794; cv=none;
 d=google.com; s=arc-20240605;
 b=GqjFkR3PsCF0KYKlZqFn5zPj9tj1nnquEcpf/VWixBnwGbblQgzsKBXzNAmy8w88p6
 hRkJfK9WerTnAFgikYbM7ubEIH88Zpyc+SL1pCWyrjOy79yZOv7ib3I9QUOm3ccot3qT
 /Tz9HDV15iiMk3sYZ+EHk6jUQdK9yqN/pJMdtPNPEPnFYc8TuV2SNN3xHvaM/gXwQAfl
 OxJQXQaMfoXZw0EBv/MIRMekCZUQzxml1oZIbtGQT7+jLBR2YARXpEUIIQC5YaIOOHBZ
 dvPjPEO9r/IoZa4TH8lu3LBtbpJftcQQkkhs4jD/y8J3CtX6Vbc7c7EkwQ9+R3esAtGf
 +ZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=L16ZX0NyxLaqH0LP9TK/fDXUsxQDPhFmtvD9FKS3ePk=;
 fh=h3dtubfFoFn47i2BT7baUpZSdEIpCuPvzhMjSFn02bI=;
 b=HM9MSELpZIpZgnZlg2SR/alpKWirX/4wj7TMk3bVnNYX0fkcap47oChtDbm6XKHH7e
 SzUU4z3lEJ+xlXTUM968U6nZ/4W6/clQCSyvz6WggRn951Y0+G7pI/sRaGoqtgpJQ4M5
 mvERx8gXdAiVZiQ/03zP36ydp/Y8cpUCJHW0lxdkyjLnV/RMr8ufNc5OfMD4p9Q9AYtE
 Edsh74d6SIkHcBOqiNZPLPgvr0zYvVydCZxFQFhkeH7xeSA0RmeRSJFVKA5z/KJefo8y
 CUqg2ts2p3S3R6N2Q1bNODTTWgsNh3UAdW8yoFO3lF+x2xdvg/mLue0XydC7dJfxcOyb
 adMg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1772589794; x=1773194594; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L16ZX0NyxLaqH0LP9TK/fDXUsxQDPhFmtvD9FKS3ePk=;
 b=NpoWxk+q+chn/k7g9Q0r73K0gtIHWOWWOMe1Mv64cg67Yk1flKVY7MDUV7MfjlTCbH
 leZzekkS+YMvolvlYEF05FvaG4hS69nfkYWsvsf6ZAsBSF716807WzjJL6kr2mJRgNny
 bZ2IpEISkdKguLHwUavLWCBV/qA6ZpZYcKtZQ=
X-Forwarded-Encrypted: i=1;
 AJvYcCWTVtusyOm+sHrUXcYqbE8FfKQcBUJ+Q5jMj1+K+2SdoMctWEN8IUJJa8ymRuz+JyQ5ZCk=@dpdk.org
X-Received: by 2002:aa7:c98b:0:b0:65b:a5cd:a148 with SMTP id
 4fb4d7f45d1cf-660a45cf65fmr1697687a12.7.1772589793460; 
 Tue, 03 Mar 2026 18:03:13 -0800 (PST)
X-Received: by 2002:aa7:c98b:0:b0:65b:a5cd:a148 with SMTP id
 4fb4d7f45d1cf-660a45cf65fmr1697673a12.7.1772589792628; Tue, 03 Mar 2026
 18:03:12 -0800 (PST)
MIME-Version: 1.0
References: <20251114175112.1103784-1-stephen@networkplumber.org>
 <CACZ4nhtooChGsnDsSHfDy_ZYcFGzqKxuWMO-GagGkUHrbDgNQg@mail.gmail.com>
In-Reply-To: <CACZ4nhtooChGsnDsSHfDy_ZYcFGzqKxuWMO-GagGkUHrbDgNQg@mail.gmail.com>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Tue, 3 Mar 2026 21:02:51 -0500
X-Gm-Features: AaiRm52_MGrjYT9GSMBEJVh6YET7XTGcBSWHmmlkt_ye-n0Pf-MRu1fq4tDHShA
Message-ID: <CA+BST0=5mgHmmzjiTrar3-ufTgZjOtUWgZhuKTc6U0Xnq9SLug@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: remove unbuilt source files
To: Ajit Khaparde <ajit.khaparde@broadcom.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 shuanglin.wang@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Shahaji Bhosle <shahaji.bhosle@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000035515064c293929"
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

--000000000000035515064c293929
Content-Type: multipart/alternative; boundary="000000000000ec98e2064c293814"

--000000000000ec98e2064c293814
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 2:24=E2=80=AFPM Ajit Khaparde <ajit.khaparde@broadc=
om.com>
wrote:
>
> On Fri, Nov 14, 2025 at 9:51=E2=80=AFAM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > Several C files are never used or built.
> > Looks like they were converted to header files but the old source
> > was never removed.
> >
> > Fixes: aa49b38fa7c3 ("net/bnxt/tf_core: cleanup external EM support")
> > Cc: shuanglin.wang@broadcom.com
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Acked-by: Kishore Padmanabha<kishore.padmanabha@broadcom.com>
>
> > ---
> >  .../net/bnxt/tf_core/cfa_tcam_mgr_session.c   |  390 ------
> >  drivers/net/bnxt/tf_core/tf_em_common.c       |   23 -
> >  drivers/net/bnxt/tf_core/tf_em_host.c         |   23 -
> >  drivers/net/bnxt/tf_ulp/ulp_utils.c           | 1100 -----------------
> >  4 files changed, 1536 deletions(-)
> >  delete mode 100644 drivers/net/bnxt/tf_core/cfa_tcam_mgr_session.c
> >  delete mode 100644 drivers/net/bnxt/tf_core/tf_em_common.c
> >  delete mode 100644 drivers/net/bnxt/tf_core/tf_em_host.c
> >  delete mode 100644 drivers/net/bnxt/tf_ulp/ulp_utils.c
> >
> > diff --git a/drivers/net/bnxt/tf_core/cfa_tcam_mgr_session.c
b/drivers/net/bnxt/tf_core/cfa_tcam_mgr_session.c
> > deleted file mode 100644
> > index 40bbcc54c8..0000000000
> > --- a/drivers/net/bnxt/tf_core/cfa_tcam_mgr_session.c
> > +++ /dev/null
> > @@ -1,390 +0,0 @@
> > -/* SPDX-License-Identifier: BSD-3-Clause
> > - * Copyright(c) 2021-2023 Broadcom
> > - * All rights reserved.
> > - */
> > -
> > -#include <inttypes.h>
> > -#include "hcapi_cfa_defs.h"
> > -#include "tf_util.h"
> > -#include "cfa_tcam_mgr.h"
> > -#include "cfa_tcam_mgr_device.h"
> > -#include "cfa_tcam_mgr_session.h"
> > -#include "cfa_tcam_mgr_sbmp.h"
> > -#include "tfp.h"
> > -#include "cfa_tcam_mgr_p58.h"
> > -#include "cfa_tcam_mgr_p4.h"
> > -
> > -struct cfa_tcam_mgr_session_data {
> > -       uint32_t session_id;
> > -       /* The following are per-session values */
> > -       uint16_t max_entries[TF_DIR_MAX][CFA_TCAM_MGR_TBL_TYPE_MAX];
> > -       uint16_t used_entries[TF_DIR_MAX][CFA_TCAM_MGR_TBL_TYPE_MAX];
> > -};
> > -
> > -static struct cfa_tcam_mgr_session_data
session_data[TF_TCAM_MAX_SESSIONS];
> > -
> > -static uint16_t last_entry_id;
> > -
> > -static struct sbmp *session_bmp[TF_TCAM_MAX_SESSIONS];
> > -
> > -int
> > -cfa_tcam_mgr_session_init(int sess_idx, enum cfa_tcam_mgr_device_type
type)
> > -{
> > -       int rc;
> > -
> > -       switch (type) {
> > -       case CFA_TCAM_MGR_DEVICE_TYPE_P4:
> > -       case CFA_TCAM_MGR_DEVICE_TYPE_SR:
> > -               rc =3D cfa_tcam_mgr_sess_table_get_p4(sess_idx,
&session_bmp[sess_idx]);
> > -               break;
> > -       case CFA_TCAM_MGR_DEVICE_TYPE_P5:
> > -               rc =3D cfa_tcam_mgr_sess_table_get_p58(sess_idx,
&session_bmp[sess_idx]);
> > -               break;
> > -       default:
> > -               CFA_TCAM_MGR_LOG(ERR, "No such device %d\n", type);
> > -               rc =3D -CFA_TCAM_MGR_ERR_CODE(NODEV);
> > -       }
> > -
> > -       return rc;
> > -}
> > -
> > -int
> > -cfa_tcam_mgr_get_session_from_context(struct cfa_tcam_mgr_context
*context,
> > -                                     uint32_t *session_id)
> > -{
> > -       if (context =3D=3D NULL) {
> > -               CFA_TCAM_MGR_LOG_0(ERR, "context passed as NULL
pointer.\n");
> > -               return -CFA_TCAM_MGR_ERR_CODE(INVAL);
> > -       }
> > -
> > -       *session_id =3D context->tfp->session->session_id.id;
> > -       return 0;
> > -}
> > -
> > -int
> > -cfa_tcam_mgr_session_find(unsigned int session_id)
> > -{
> > -       unsigned int sess_idx;
> > -
> > -       for (sess_idx =3D 0; sess_idx < ARRAY_SIZE(session_data);
sess_idx++) {
> > -               if (session_data[sess_idx].session_id =3D=3D session_id=
)
> > -                       return sess_idx;
> > -       }
> > -
> > -       return -CFA_TCAM_MGR_ERR_CODE(INVAL);
> > -}
> > -
> > -int
> > -cfa_tcam_mgr_session_empty(void)
> > -{
> > -       unsigned int sess_idx;
> > -
> > -       for (sess_idx =3D 0; sess_idx < ARRAY_SIZE(session_data);
sess_idx++) {
> > -               if (session_data[sess_idx].session_id)
> > -                       return 0;
> > -       }
> > -
> > -       return 1;
> > -}
> > -
> > -int
> > -cfa_tcam_mgr_session_add(unsigned int session_id)
> > -{
> > -       int sess_idx;
> > -
> > -       sess_idx =3D cfa_tcam_mgr_session_find(session_id);
> > -       if (sess_idx >=3D 0) {
> > -               CFA_TCAM_MGR_LOG_0(ERR, "Session is already bound.\n");
> > -               return -CFA_TCAM_MGR_ERR_CODE(BUSY);
> > -       }
> > -
> > -       /* Session not found in table, find first empty entry. */
> > -       for (sess_idx =3D 0;
> > -            sess_idx < (signed int)ARRAY_SIZE(session_data);
> > -            sess_idx++) {
> > -               if (session_data[sess_idx].session_id =3D=3D 0)
> > -                       break;
> > -       }
> > -
> > -       if (sess_idx >=3D (signed int)ARRAY_SIZE(session_data)) {
> > -               /* No room in the session table */
> > -               CFA_TCAM_MGR_LOG_0(ERR, "Session table is full.\n");
> > -               return -CFA_TCAM_MGR_ERR_CODE(NOMEM);
> > -       }
> > -
> > -       session_data[sess_idx].session_id =3D session_id;
> > -
> > -       return sess_idx;
> > -}
> > -
> > -int
> > -cfa_tcam_mgr_session_free(unsigned int session_id,
> > -               struct cfa_tcam_mgr_context *context)
> > -{
> > -       struct cfa_tcam_mgr_free_parms free_parms;
> > -       int entry_id;
> > -       int sess_idx =3D cfa_tcam_mgr_session_find(session_id);
> > -
> > -       if (sess_idx < 0)
> > -               return sess_idx;
> > -
> > -       memset(&free_parms, 0, sizeof(free_parms));
> > -       /* Since we are freeing all pending TCAM entries (which is
typically
> > -        * done during tcam_unbind), we don't know the type of each
entry.
> > -        * So we set the type to MAX as a hint to cfa_tcam_mgr_free() t=
o
> > -        * figure out the actual type. We need to set it through each
> > -        * iteration in the loop below; otherwise, the type determined
for
> > -        * the first entry would be used for subsequent entries that
may or
> > -        * may not be of the same type, resulting in errors.
> > -        */
> > -       for (entry_id =3D 0; entry_id <
cfa_tcam_mgr_max_entries[sess_idx]; entry_id++) {
> > -               if (SBMP_MEMBER(session_bmp[sess_idx][entry_id],
sess_idx)) {
> > -
SBMP_SESSION_REMOVE(session_bmp[sess_idx][entry_id], sess_idx);
> > -
> > -                       free_parms.id =3D entry_id;
> > -                       free_parms.type =3D CFA_TCAM_MGR_TBL_TYPE_MAX;
> > -                       cfa_tcam_mgr_free(context, &free_parms);
> > -               }
> > -       }
> > -
> > -       memset(&session_data[sess_idx], 0,
sizeof(session_data[sess_idx]));
> > -       return 0;
> > -}
> > -
> > -int
> > -cfa_tcam_mgr_session_cfg(unsigned int session_id,
> > -                        uint16_t tcam_cnt[][CFA_TCAM_MGR_TBL_TYPE_MAX]=
)
> > -{
> > -       struct cfa_tcam_mgr_table_data *table_data;
> > -       struct cfa_tcam_mgr_session_data *session_entry;
> > -       unsigned int dir, type;
> > -       int sess_idx =3D cfa_tcam_mgr_session_find(session_id);
> > -       uint16_t requested_cnt;
> > -
> > -       if (sess_idx < 0)
> > -               return sess_idx;
> > -
> > -       session_entry =3D &session_data[sess_idx];
> > -
> > -       /* Validate session request */
> > -       for (dir =3D 0; dir < ARRAY_SIZE(cfa_tcam_mgr_tables[sess_idx])=
;
dir++) {
> > -               for (type =3D 0;
> > -                    type <
ARRAY_SIZE(cfa_tcam_mgr_tables[sess_idx][dir]);
> > -                    type++) {
> > -                       table_data =3D
&cfa_tcam_mgr_tables[sess_idx][dir][type];
> > -                       requested_cnt =3D tcam_cnt[dir][type];
> > -                       /*
> > -                        * Only check if table supported (max_entries >
0).
> > -                        */
> > -                       if (table_data->max_entries > 0 &&
> > -                           requested_cnt > table_data->max_entries) {
> > -                               CFA_TCAM_MGR_LOG_DIR_TYPE(ERR, dir,
type,
> > -                                               "Requested %d,
available %d.\n",
> > -                                               requested_cnt,
> > -
table_data->max_entries);
> > -                               return -CFA_TCAM_MGR_ERR_CODE(NOSPC);
> > -                       }
> > -               }
> > -       }
> > -
> > -       memcpy(session_entry->max_entries, tcam_cnt,
> > -              sizeof(session_entry->max_entries));
> > -       return 0;
> > -}
> > -
> > -void
> > -cfa_tcam_mgr_mv_session_used_entries_cnt(int sess_idx, enum tf_dir dir=
,
> > -                                        enum cfa_tcam_mgr_tbl_type
dst_type,
> > -                                        enum cfa_tcam_mgr_tbl_type
src_type)
> > -{
> > -       session_data[sess_idx].used_entries[dir][dst_type]++;
> > -       session_data[sess_idx].used_entries[dir][src_type]--;
> > -}
> > -
> > -int
> > -cfa_tcam_mgr_session_entry_alloc(unsigned int session_id,
> > -                                enum tf_dir dir,
> > -                                enum cfa_tcam_mgr_tbl_type type)
> > -{
> > -       int sess_idx;
> > -
> > -       sess_idx =3D cfa_tcam_mgr_session_find(session_id);
> > -       if (sess_idx < 0) {
> > -               CFA_TCAM_MGR_LOG_0(ERR, "Session not found.\n");
> > -               return -CFA_TCAM_MGR_ERR_CODE(NODEV);
> > -       }
> > -
> > -       if (session_data[sess_idx].used_entries[dir][type] >=3D
> > -           session_data[sess_idx].max_entries[dir][type]) {
> > -               CFA_TCAM_MGR_LOG_0(ERR, "Table full (session).\n");
> > -               return -CFA_TCAM_MGR_ERR_CODE(NOSPC);
> > -       }
> > -
> > -       do {
> > -               last_entry_id++;
> > -               if (cfa_tcam_mgr_max_entries[sess_idx] <=3D last_entry_=
id)
> > -                       last_entry_id =3D 0;
> > -       } while (!SBMP_IS_NULL(session_bmp[sess_idx][last_entry_id]));
> > -
> > -       SBMP_SESSION_ADD(session_bmp[sess_idx][last_entry_id],
sess_idx);
> > -
> > -       session_data[sess_idx].used_entries[dir][type] +=3D 1;
> > -
> > -       return last_entry_id;
> > -}
> > -
> > -int
> > -cfa_tcam_mgr_session_entry_free(unsigned int session_id,
> > -                               unsigned int entry_id,
> > -                               enum tf_dir dir,
> > -                               enum cfa_tcam_mgr_tbl_type type)
> > -{
> > -       int sess_idx;
> > -
> > -       sess_idx =3D cfa_tcam_mgr_session_find(session_id);
> > -       if (sess_idx < 0) {
> > -               CFA_TCAM_MGR_LOG_0(ERR, "Session not found.\n");
> > -               return -CFA_TCAM_MGR_ERR_CODE(NODEV);
> > -       }
> > -
> > -       SBMP_SESSION_REMOVE(session_bmp[sess_idx][entry_id], sess_idx);
> > -       session_data[sess_idx].used_entries[dir][type] -=3D 1;
> > -
> > -       return 0;
> > -}
> > -
> > -#if SBMP_WORD_WIDTH =3D=3D 16
> > -#define SBMP_FORMAT PRIX16
> > -#define SBMP_PRECISION "4"
> > -#elif SBMP_WORD_WIDTH =3D=3D 32
> > -#define SBMP_FORMAT PRIX32
> > -#define SBMP_PRECISION "8"
> > -#elif SBMP_WORD_WIDTH =3D=3D 64
> > -#define SBMP_FORMAT PRIX64
> > -#define SBMP_PRECISION "16"
> > -#else
> > -#error "Invalid value for SBMP_WORD_WIDTH."
> > -#endif
> > -
> > -static void
> > -cfa_tcam_mgr_session_bitmap_print(struct sbmp *session_bmp)
> > -{
> > -       unsigned int i;
> > -
> > -       printf("0x");
> > -       for (i =3D 0;
> > -            i < ARRAY_SIZE(session_bmp->bits);
> > -            i++) {
> > -               printf("%0" SBMP_PRECISION SBMP_FORMAT,
> > -                      session_bmp->bits[i]);
> > -       }
> > -}
> > -
> > -#define SESSION_DUMP_HEADER_1 "                             RX
 TX\n"
> > -#define SESSION_DUMP_HEADER_2 \
> > -       "                         Max   Used  Max   Used\n"
> > -
> > -static void
> > -cfa_tcam_mgr_session_printf(struct cfa_tcam_mgr_session_data *session,
> > -                           enum cfa_tcam_mgr_tbl_type tbl_type)
> > -{
> > -       printf("%-22s: %5u %5u %5u %5u\n",
> > -              cfa_tcam_mgr_tbl_2_str(tbl_type),
> > -              session->max_entries[TF_DIR_RX][tbl_type],
> > -              session->used_entries[TF_DIR_RX][tbl_type],
> > -              session->max_entries[TF_DIR_TX][tbl_type],
> > -              session->used_entries[TF_DIR_TX][tbl_type]);
> > -}
> > -
> > -void
> > -cfa_tcam_mgr_sessions_dump(void)
> > -{
> > -       struct cfa_tcam_mgr_session_data *session;
> > -       unsigned int sess_idx;
> > -       bool sess_found =3D false;
> > -       enum cfa_tcam_mgr_tbl_type tbl_type;
> > -
> > -       printf("\nTCAM Sessions Table:\n");
> > -       for (sess_idx =3D 0; sess_idx < ARRAY_SIZE(session_data);
sess_idx++) {
> > -               if (session_data[sess_idx].session_id !=3D 0) {
> > -                       session =3D &session_data[sess_idx];
> > -                       if (!sess_found) {
> > -                               printf(SESSION_DUMP_HEADER_1);
> > -                               printf(SESSION_DUMP_HEADER_2);
> > -                       }
> > -                       printf("Session 0x%08x:\n",
> > -                              session->session_id);
> > -                       for (tbl_type =3D CFA_TCAM_MGR_TBL_TYPE_START;
> > -                            tbl_type < CFA_TCAM_MGR_TBL_TYPE_MAX;
> > -                            tbl_type++) {
> > -                               cfa_tcam_mgr_session_printf(session,
tbl_type);
> > -                       }
> > -                       sess_found =3D true;
> > -               }
> > -       }
> > -
> > -       if (!sess_found)
> > -               printf("No sessions found.\n");
> > -}
> > -
> > -/* This dumps all the sessions using an entry */
> > -void
> > -cfa_tcam_mgr_entry_sessions_dump(int sess_idx, uint16_t id)
> > -{
> > -       bool session_found =3D false;
> > -
> > -       if (id >=3D cfa_tcam_mgr_max_entries[sess_idx]) {
> > -               printf("Entry ID %u out of range for sess_idx %d.  Max
ID %u.\n",
> > -                      id, sess_idx, cfa_tcam_mgr_max_entries[sess_idx]
- 1);
> > -               return;
> > -       }
> > -
> > -       if (!SBMP_IS_NULL(session_bmp[sess_idx][id])) {
> > -               printf("Sessions using entry ID %u:\n", id);
> > -               for (sess_idx =3D 0; sess_idx < SBMP_SESSION_MAX;
sess_idx++)
> > -                       if (SBMP_MEMBER(session_bmp[sess_idx][id],
(sess_idx))) {
> > -                               if (session_data[sess_idx].session_id
!=3D 0) {
> > -                                       printf("0x%08x (index %d)\n",
> > -
session_data[sess_idx].session_id,
> > -                                         sess_idx);
> > -                                       session_found =3D true;
> > -                               } else {
> > -                                       printf("Error! Entry ID %u used
by "
> > -                                              "session index %d which
is not "
> > -                                              "in use.\n",
> > -                                              id, sess_idx);
> > -                               }
> > -                       }
> > -               if (!session_found)
> > -                       printf("No sessions using entry ID %u.\n", id);
> > -       } else {
> > -               printf("Entry ID %u not in use.\n",
> > -                      id);
> > -               return;
> > -       }
> > -}
> > -
> > -/* This dumps all the entries in use by any session */
> > -void
> > -cfa_tcam_mgr_session_entries_dump(int sess_idx)
> > -{
> > -       bool entry_found =3D false;
> > -       uint16_t id;
> > -
> > -       printf("\nGlobal Maximum Entries for sess_idx %d: %d\n\n",
> > -              sess_idx, cfa_tcam_mgr_max_entries[sess_idx]);
> > -       printf("TCAM Session Entry Table:\n");
> > -       for (id =3D 0; id < cfa_tcam_mgr_max_entries[sess_idx]; id++) {
> > -               if (!SBMP_IS_NULL(session_bmp[sess_idx][id])) {
> > -                       if (!entry_found)
> > -                               printf("  EID Session bitmap\n");
> > -                       printf("%5u ", id);
> > -
cfa_tcam_mgr_session_bitmap_print(&session_bmp[sess_idx][id]);
> > -                       printf("\n");
> > -                       entry_found =3D true;
> > -               }
> > -       }
> > -
> > -       if (!entry_found)
> > -               printf("No entries found.\n");
> > -}
> > diff --git a/drivers/net/bnxt/tf_core/tf_em_common.c
b/drivers/net/bnxt/tf_core/tf_em_common.c
> > deleted file mode 100644
> > index 2449759db0..0000000000
> > --- a/drivers/net/bnxt/tf_core/tf_em_common.c
> > +++ /dev/null
> > @@ -1,23 +0,0 @@
> > -/* SPDX-License-Identifier: BSD-3-Clause
> > - * Copyright(c) 2019-2023 Broadcom
> > - * All rights reserved.
> > - */
> > -
> > -#include <string.h>
> > -#include <math.h>
> > -#include <sys/param.h>
> > -#include <rte_common.h>
> > -#include <rte_errno.h>
> > -#include <rte_log.h>
> > -#include "tf_core.h"
> > -#include "tf_util.h"
> > -#include "tf_common.h"
> > -#include "tf_em.h"
> > -#include "tf_em_common.h"
> > -#include "tf_msg.h"
> > -#include "tfp.h"
> > -#include "tf_device.h"
> > -#include "tf_ext_flow_handle.h"
> > -#include "hcapi_cfa.h"
> > -#include "bnxt.h"
> > -
> > diff --git a/drivers/net/bnxt/tf_core/tf_em_host.c
b/drivers/net/bnxt/tf_core/tf_em_host.c
> > deleted file mode 100644
> > index 6db0057b2c..0000000000
> > --- a/drivers/net/bnxt/tf_core/tf_em_host.c
> > +++ /dev/null
> > @@ -1,23 +0,0 @@
> > -/* SPDX-License-Identifier: BSD-3-Clause
> > - * Copyright(c) 2019-2023 Broadcom
> > - * All rights reserved.
> > - */
> > -
> > -#include <string.h>
> > -#include <math.h>
> > -#include <sys/param.h>
> > -#include <rte_common.h>
> > -#include <rte_errno.h>
> > -#include <rte_log.h>
> > -
> > -#include "tf_core.h"
> > -#include "tf_util.h"
> > -#include "tf_common.h"
> > -#include "tf_em.h"
> > -#include "tf_em_common.h"
> > -#include "tf_msg.h"
> > -#include "tfp.h"
> > -#include "lookup3.h"
> > -#include "tf_ext_flow_handle.h"
> > -
> > -#include "bnxt.h"
> > diff --git a/drivers/net/bnxt/tf_ulp/ulp_utils.c
b/drivers/net/bnxt/tf_ulp/ulp_utils.c
> > deleted file mode 100644
> > index 85e309d7a2..0000000000
> > --- a/drivers/net/bnxt/tf_ulp/ulp_utils.c
> > +++ /dev/null
> > @@ -1,1100 +0,0 @@
> > -/* SPDX-License-Identifier: BSD-3-Clause
> > - * Copyright(c) 2014-2023 Broadcom
> > - * All rights reserved.
> > - */
> > -
> > -#include <rte_common.h>
> > -#include "ulp_utils.h"
> > -#include "bnxt_tf_common.h"
> > -
> > -/*
> > - * Initialize the regfile structure for writing
> > - *
> > - * regfile [in] Ptr to a regfile instance
> > - *
> > - * returns zero on success
> > - */
> > -int32_t
> > -ulp_regfile_init(struct ulp_regfile *regfile)
> > -{
> > -       /* validate the arguments */
> > -       if (!regfile) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> > -               return -EINVAL;
> > -       }
> > -       memset(regfile, 0, sizeof(struct ulp_regfile));
> > -       return 0; /* Success */
> > -}
> > -
> > -/*
> > - * Read a value from the regfile
> > - *
> > - * regfile [in] The regfile instance. Must be initialized prior to
being used
> > - *
> > - * field [in] The field to be read within the regfile.
> > - *
> > - * data [in/out]
> > - *
> > - * returns zero on success
> > - */
> > -int32_t
> > -ulp_regfile_read(struct ulp_regfile *regfile,
> > -                enum bnxt_ulp_rf_idx field,
> > -                uint64_t *data)
> > -{
> > -       /* validate the arguments */
> > -       if (!regfile || field >=3D BNXT_ULP_RF_IDX_LAST) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> > -               return -EINVAL;
> > -       }
> > -
> > -       *data =3D regfile->entry[field].data;
> > -       return 0;
> > -}
> > -
> > -/*
> > - * Write a value to the regfile
> > - *
> > - * regfile [in] The regfile instance.  Must be initialized prior to
being used
> > - *
> > - * field [in] The field to be written within the regfile.
> > - *
> > - * data [in] The value is written into this variable.  It is going to
be in the
> > - * same byte order as it was written.
> > - *
> > - * size [in] The size in bytes of the value being written into this
> > - * variable.
> > - *
> > - * returns 0 on success
> > - */
> > -int32_t
> > -ulp_regfile_write(struct ulp_regfile *regfile,
> > -                 enum bnxt_ulp_rf_idx field,
> > -                 uint64_t data)
> > -{
> > -       /* validate the arguments */
> > -       if (!regfile || field >=3D BNXT_ULP_RF_IDX_LAST) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> > -               return -EINVAL; /* failure */
> > -       }
> > -
> > -       regfile->entry[field].data =3D data;
> > -       return 0; /* Success */
> > -}
> > -
> > -static void
> > -ulp_bs_put_msb(uint8_t *bs, uint16_t bitpos, uint8_t bitlen, uint8_t
val)
> > -{
> > -       uint8_t bitoffs =3D bitpos % 8;
> > -       uint16_t index  =3D bitpos / 8;
> > -       uint8_t mask;
> > -       uint8_t tmp;
> > -       int8_t shift;
> > -
> > -       tmp =3D bs[index];
> > -       mask =3D ((uint8_t)-1 >> (8 - bitlen));
> > -       shift =3D 8 - bitoffs - bitlen;
> > -       val &=3D mask;
> > -
> > -       if (shift >=3D 0) {
> > -               tmp &=3D ~(mask << shift);
> > -               tmp |=3D val << shift;
> > -               bs[index] =3D tmp;
> > -       } else {
> > -               tmp &=3D ~((uint8_t)-1 >> bitoffs);
> > -               tmp |=3D val >> -shift;
> > -               bs[index++] =3D tmp;
> > -
> > -               tmp =3D bs[index];
> > -               tmp &=3D ((uint8_t)-1 >> (bitlen - (8 - bitoffs)));
> > -               tmp |=3D val << (8 + shift);
> > -               bs[index] =3D tmp;
> > -       }
> > -}
> > -
> > -static void
> > -ulp_bs_put_lsb(uint8_t *bs, uint16_t bitpos, uint8_t bitlen, uint8_t
val)
> > -{
> > -       uint8_t bitoffs =3D bitpos % 8;
> > -       uint16_t index  =3D bitpos / 8;
> > -       uint8_t mask;
> > -       uint8_t tmp;
> > -       uint8_t shift;
> > -       uint8_t partial;
> > -
> > -       tmp =3D bs[index];
> > -       shift =3D bitoffs;
> > -
> > -       if (bitoffs + bitlen <=3D 8) {
> > -               mask =3D ((1 << bitlen) - 1) << shift;
> > -               tmp &=3D ~mask;
> > -               tmp |=3D ((val << shift) & mask);
> > -               bs[index] =3D tmp;
> > -       } else {
> > -               partial =3D 8 - bitoffs;
> > -               mask =3D ((1 << partial) - 1) << shift;
> > -               tmp &=3D ~mask;
> > -               tmp |=3D ((val << shift) & mask);
> > -               bs[index++] =3D tmp;
> > -
> > -               val >>=3D partial;
> > -               partial =3D bitlen - partial;
> > -               mask =3D ((1 << partial) - 1);
> > -               tmp =3D bs[index];
> > -               tmp &=3D ~mask;
> > -               tmp |=3D (val & mask);
> > -               bs[index] =3D tmp;
> > -       }
> > -}
> > -
> > -/*
> > - * Add data to the byte array in Little endian format.
> > - *
> > - * bs [in] The byte array where data is pushed
> > - *
> > - * pos [in] The offset where data is pushed
> > - *
> > - * len [in] The number of bits to be added to the data array.
> > - *
> > - * val [in] The data to be added to the data array.
> > - *
> > - * returns the number of bits pushed.
> > - */
> > -uint32_t
> > -ulp_bs_push_lsb(uint8_t *bs, uint16_t pos, uint8_t len, uint8_t *val)
> > -{
> > -       int i;
> > -       int cnt =3D (len) / 8;
> > -       int tlen =3D len;
> > -
> > -       if (cnt > 0 && !(len % 8))
> > -               cnt -=3D 1;
> > -
> > -       for (i =3D 0; i < cnt; i++) {
> > -               ulp_bs_put_lsb(bs, pos, 8, val[cnt - i]);
> > -               pos +=3D 8;
> > -               tlen -=3D 8;
> > -       }
> > -
> > -       /* Handle the remainder bits */
> > -       if (tlen)
> > -               ulp_bs_put_lsb(bs, pos, tlen, val[0]);
> > -       return len;
> > -}
> > -
> > -/*
> > - * Add data to the byte array in Big endian format.
> > - *
> > - * bs [in] The byte array where data is pushed
> > - *
> > - * pos [in] The offset where data is pushed
> > - *
> > - * len [in] The number of bits to be added to the data array.
> > - *
> > - * val [in] The data to be added to the data array.
> > - *
> > - * returns the number of bits pushed.
> > - */
> > -uint32_t
> > -ulp_bs_push_msb(uint8_t *bs, uint16_t pos, uint8_t len, uint8_t *val)
> > -{
> > -       int i;
> > -       int cnt =3D (len + 7) / 8;
> > -
> > -       /* Handle any remainder bits */
> > -       int tmp =3D len % 8;
> > -
> > -       if (!tmp)
> > -               tmp =3D 8;
> > -
> > -       ulp_bs_put_msb(bs, pos, tmp, val[0]);
> > -
> > -       pos +=3D tmp;
> > -
> > -       for (i =3D 1; i < cnt; i++) {
> > -               ulp_bs_put_msb(bs, pos, 8, val[i]);
> > -               pos +=3D 8;
> > -       }
> > -
> > -       return len;
> > -}
> > -
> > -/*
> > - * Initializes the blob structure for creating binary blob
> > - *
> > - * blob [in] The blob to be initialized
> > - *
> > - * bitlen [in] The bit length of the blob
> > - *
> > - * order [in] The byte order for the blob.  Currently only supporting
> > - * big endian.  All fields are packed with this order.
> > - *
> > - * returns zero on success
> > - * Notes - If bitlen is zero then set it to max.
> > - */
> > -int32_t
> > -ulp_blob_init(struct ulp_blob *blob,
> > -             uint16_t bitlen,
> > -             enum bnxt_ulp_byte_order order)
> > -{
> > -       /* validate the arguments */
> > -       if (!blob || bitlen > (8 * sizeof(blob->data))) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> > -               return -EINVAL;
> > -       }
> > -       if (bitlen)
> > -               blob->bitlen =3D bitlen;
> > -       else
> > -               blob->bitlen =3D BNXT_ULP_FLMP_BLOB_SIZE_IN_BITS;
> > -       blob->byte_order =3D order;
> > -       blob->write_idx =3D 0;
> > -       memset(blob->data, 0, sizeof(blob->data));
> > -       return 0; /* Success */
> > -}
> > -
> > -/*
> > - * Add data to the binary blob at the current offset.
> > - *
> > - * blob [in] The blob that data is added to.  The blob must
> > - * be initialized prior to pushing data.
> > - *
> > - * data [in] A pointer to bytes to be added to the blob.
> > - *
> > - * datalen [in] The number of bits to be added to the blob.
> > - *
> > - * The offset of the data is updated after each push of data.
> > - *
> > - * returns zero on success
> > - */
> > -#define ULP_BLOB_BYTE          8
> > -#define ULP_BLOB_BYTE_HEX      0xFF
> > -#define BLOB_MASK_CAL(x)       ((0xFF << (x)) & 0xFF)
> > -int32_t
> > -ulp_blob_push(struct ulp_blob *blob,
> > -             uint8_t *data,
> > -             uint32_t datalen)
> > -{
> > -       uint32_t rc;
> > -
> > -       /* validate the arguments */
> > -       if (!blob || datalen > (uint32_t)(blob->bitlen -
blob->write_idx)) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> > -               return -EINVAL;
> > -       }
> > -
> > -       if (blob->byte_order =3D=3D BNXT_ULP_BYTE_ORDER_BE)
> > -               rc =3D ulp_bs_push_msb(blob->data,
> > -                                    blob->write_idx,
> > -                                    datalen,
> > -                                    data);
> > -       else
> > -               rc =3D ulp_bs_push_lsb(blob->data,
> > -                                    blob->write_idx,
> > -                                    datalen,
> > -                                    data);
> > -       if (!rc) {
> > -               BNXT_DRV_DBG(ERR, "Failed to write blob\n");
> > -               return -EINVAL;
> > -       }
> > -       blob->write_idx +=3D datalen;
> > -       return 0;
> > -}
> > -
> > -/*
> > - * Insert data into the binary blob at the given offset.
> > - *
> > - * blob [in] The blob that data is added to.  The blob must
> > - * be initialized prior to pushing data.
> > - *
> > - * offset [in] The offset where the data needs to be inserted.
> > - *
> > - * data [in/out] A pointer to bytes to be added to the blob.
> > - *
> > - * datalen [in] The number of bits to be added to the blob.
> > - *
> > - * The offset of the data is updated after each push of data.
> > - *
> > - * returns zero on success
> > - */
> > -int32_t
> > -ulp_blob_insert(struct ulp_blob *blob, uint32_t offset,
> > -               uint8_t *data, uint32_t datalen)
> > -{
> > -       uint32_t rc;
> > -       uint8_t local_data[BNXT_ULP_FLMP_BLOB_SIZE];
> > -       uint16_t mov_len;
> > -
> > -       /* validate the arguments */
> > -       if (!blob || datalen > (uint32_t)(blob->bitlen -
blob->write_idx) ||
> > -           offset > blob->write_idx) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> > -               return -EINVAL;
> > -       }
> > -
> > -       mov_len =3D blob->write_idx - offset;
> > -       /* If offset and data len are not 8 bit aligned then return
error */
> > -       if (ULP_BITS_IS_BYTE_NOT_ALIGNED(offset) ||
> > -           ULP_BITS_IS_BYTE_NOT_ALIGNED(datalen)) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument, not aligned\n");
> > -               return -EINVAL;
> > -       }
> > -
> > -       /* copy the data so we can move the data */
> > -       memcpy(local_data, &blob->data[ULP_BITS_2_BYTE_NR(offset)],
> > -              ULP_BITS_2_BYTE(mov_len));
> > -       blob->write_idx =3D offset;
> > -       if (blob->byte_order =3D=3D BNXT_ULP_BYTE_ORDER_BE)
> > -               rc =3D ulp_bs_push_msb(blob->data,
> > -                                    blob->write_idx,
> > -                                    datalen,
> > -                                    data);
> > -       else
> > -               rc =3D ulp_bs_push_lsb(blob->data,
> > -                                    blob->write_idx,
> > -                                    datalen,
> > -                                    data);
> > -       if (!rc) {
> > -               BNXT_DRV_DBG(ERR, "Failed to write blob\n");
> > -               return -EINVAL;
> > -       }
> > -       /* copy the previously stored data */
> > -       memcpy(&blob->data[ULP_BITS_2_BYTE_NR(offset + datalen)],
local_data,
> > -              ULP_BITS_2_BYTE(mov_len));
> > -       blob->write_idx +=3D (mov_len + datalen);
> > -       return 0;
> > -}
> > -
> > -/*
> > - * Add data to the binary blob at the current offset.
> > - *
> > - * blob [in] The blob that data is added to.  The blob must
> > - * be initialized prior to pushing data.
> > - *
> > - * data [in] 64-bit value to be added to the blob.
> > - *
> > - * datalen [in] The number of bits to be added to the blob.
> > - *
> > - * The offset of the data is updated after each push of data.
> > - * NULL returned on error, pointer pushed value otherwise.
> > - */
> > -uint8_t *
> > -ulp_blob_push_64(struct ulp_blob *blob,
> > -                uint64_t *data,
> > -                uint32_t datalen)
> > -{
> > -       uint8_t *val =3D (uint8_t *)data;
> > -       int rc;
> > -
> > -       int size =3D (datalen + 7) / 8;
> > -
> > -       if (!blob || !data ||
> > -           datalen > (uint32_t)(blob->bitlen - blob->write_idx)) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> > -               return NULL;
> > -       }
> > -
> > -       rc =3D ulp_blob_push(blob, &val[8 - size], datalen);
> > -       if (rc)
> > -               return NULL;
> > -
> > -       return &val[8 - size];
> > -}
> > -
> > -/*
> > - * Add data to the binary blob at the current offset.
> > - *
> > - * blob [in] The blob that data is added to.  The blob must
> > - * be initialized prior to pushing data.
> > - *
> > - * data [in] 32-bit value to be added to the blob.
> > - *
> > - * datalen [in] The number of bits to be added to the blob.
> > - *
> > - * The offset of the data is updated after each push of data.
> > - * NULL returned on error, pointer pushed value otherwise.
> > - */
> > -uint8_t *
> > -ulp_blob_push_32(struct ulp_blob *blob,
> > -                uint32_t *data,
> > -                uint32_t datalen)
> > -{
> > -       uint8_t *val =3D (uint8_t *)data;
> > -       uint32_t rc;
> > -       uint32_t size =3D ULP_BITS_2_BYTE(datalen);
> > -
> > -       if (!data || size > sizeof(uint32_t)) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> > -               return NULL;
> > -       }
> > -
> > -       rc =3D ulp_blob_push(blob, &val[sizeof(uint32_t) - size],
datalen);
> > -       if (rc)
> > -               return NULL;
> > -
> > -       return &val[sizeof(uint32_t) - size];
> > -}
> > -
> > -/*
> > - * Add encap data to the binary blob at the current offset.
> > - *
> > - * blob [in] The blob that data is added to.  The blob must
> > - * be initialized prior to pushing data.
> > - *
> > - * data [in] value to be added to the blob.
> > - *
> > - * datalen [in] The number of bits to be added to the blob.
> > - *
> > - * The offset of the data is updated after each push of data.
> > - * NULL returned on error, pointer pushed value otherwise.
> > - */
> > -int32_t
> > -ulp_blob_push_encap(struct ulp_blob *blob,
> > -                   uint8_t *data,
> > -                   uint32_t datalen)
> > -{
> > -       uint8_t         *val =3D (uint8_t *)data;
> > -       uint32_t        initial_size, write_size =3D datalen;
> > -       uint32_t        size =3D 0;
> > -
> > -       if (!blob || !data ||
> > -           datalen > (uint32_t)(blob->bitlen - blob->write_idx)) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> > -               return -1;
> > -       }
> > -
> > -       initial_size =3D ULP_BYTE_2_BITS(sizeof(uint64_t)) -
> > -           (blob->write_idx % ULP_BYTE_2_BITS(sizeof(uint64_t)));
> > -       while (write_size > 0) {
> > -               if (initial_size && write_size > initial_size) {
> > -                       size =3D initial_size;
> > -                       initial_size =3D 0;
> > -               } else if (initial_size && write_size <=3D initial_size=
) {
> > -                       size =3D write_size;
> > -                       initial_size =3D 0;
> > -               } else if (write_size >
ULP_BYTE_2_BITS(sizeof(uint64_t))) {
> > -                       size =3D ULP_BYTE_2_BITS(sizeof(uint64_t));
> > -               } else {
> > -                       size =3D write_size;
> > -               }
> > -               if (ulp_blob_push(blob, val, size)) {
> > -                       BNXT_DRV_DBG(ERR, "push field failed\n");
> > -                       return -1;
> > -               }
> > -               val +=3D ULP_BITS_2_BYTE(size);
> > -               write_size -=3D size;
> > -       }
> > -       return datalen;
> > -}
> > -
> > -/*
> > - * Adds pad to an initialized blob at the current offset
> > - *
> > - * blob [in] The blob that data is added to.  The blob must
> > - * be initialized prior to pushing data.
> > - *
> > - * datalen [in] The number of bits of pad to add
> > - *
> > - * returns the number of pad bits added, -1 on failure
> > - */
> > -int32_t
> > -ulp_blob_pad_push(struct ulp_blob *blob,
> > -                 uint32_t datalen)
> > -{
> > -       if (datalen > (uint32_t)(blob->bitlen - blob->write_idx)) {
> > -               BNXT_DRV_DBG(ERR, "Pad too large for blob\n");
> > -               return -1;
> > -       }
> > -
> > -       blob->write_idx +=3D datalen;
> > -       return datalen;
> > -}
> > -
> > -/*
> > - * Adds pad to an initialized blob at the current offset based on
> > - * the alignment.
> > - *
> > - * blob [in] The blob that needs to be aligned
> > - *
> > - * align [in] Alignment in bits.
> > - *
> > - * returns the number of pad bits added, -1 on failure
> > - */
> > -int32_t
> > -ulp_blob_pad_align(struct ulp_blob *blob,
> > -                  uint32_t align)
> > -{
> > -       int32_t pad =3D 0;
> > -
> > -       pad =3D RTE_ALIGN(blob->write_idx, align) - blob->write_idx;
> > -       if (pad > (int32_t)(blob->bitlen - blob->write_idx)) {
> > -               BNXT_DRV_DBG(ERR, "Pad too large for blob\n");
> > -               return -1;
> > -       }
> > -       blob->write_idx +=3D pad;
> > -       return pad;
> > -}
> > -
> > -/* Get data from src and put into dst using little-endian format */
> > -static void
> > -ulp_bs_get_lsb(uint8_t *src, uint16_t bitpos, uint8_t bitlen, uint8_t
*dst)
> > -{
> > -       uint8_t bitoffs =3D bitpos % ULP_BLOB_BYTE;
> > -       uint16_t index  =3D ULP_BITS_2_BYTE_NR(bitpos);
> > -       uint8_t mask, partial, shift;
> > -
> > -       shift =3D bitoffs;
> > -       partial =3D ULP_BLOB_BYTE - bitoffs;
> > -       if (bitoffs + bitlen <=3D ULP_BLOB_BYTE) {
> > -               mask =3D ((1 << bitlen) - 1) << shift;
> > -               *dst =3D (src[index] & mask) >> shift;
> > -       } else {
> > -               mask =3D ((1 << partial) - 1) << shift;
> > -               *dst =3D (src[index] & mask) >> shift;
> > -               index++;
> > -               partial =3D bitlen - partial;
> > -               mask =3D ((1 << partial) - 1);
> > -               *dst |=3D (src[index] & mask) << (ULP_BLOB_BYTE -
bitoffs);
> > -       }
> > -}
> > -
> > -/*
> > - * Get data from the byte array in Little endian format.
> > - *
> > - * src [in] The byte array where data is extracted from
> > - *
> > - * dst [out] The byte array where data is pulled into
> > - *
> > - * size [in] The size of dst array in bytes
> > - *
> > - * offset [in] The offset where data is pulled
> > - *
> > - * len [in] The number of bits to be extracted from the data array
> > - *
> > - * returns None.
> > - */
> > -void
> > -ulp_bs_pull_lsb(uint8_t *src, uint8_t *dst, uint32_t size,
> > -               uint32_t offset, uint32_t len)
> > -{
> > -       uint32_t idx;
> > -       uint32_t cnt =3D ULP_BITS_2_BYTE_NR(len);
> > -
> > -       /* iterate bytewise to get data */
> > -       for (idx =3D 0; idx < cnt; idx++) {
> > -               ulp_bs_get_lsb(src, offset, ULP_BLOB_BYTE,
> > -                              &dst[size - 1 - idx]);
> > -               offset +=3D ULP_BLOB_BYTE;
> > -               len -=3D ULP_BLOB_BYTE;
> > -       }
> > -
> > -       /* Extract the last reminder data that is not 8 byte boundary *=
/
> > -       if (len)
> > -               ulp_bs_get_lsb(src, offset, len, &dst[size - 1 - idx]);
> > -}
> > -
> > -/* Get data from src and put into dst using big-endian format */
> > -static void
> > -ulp_bs_get_msb(uint8_t *src, uint16_t bitpos, uint8_t bitlen, uint8_t
*dst)
> > -{
> > -       uint8_t bitoffs =3D bitpos % ULP_BLOB_BYTE;
> > -       uint16_t index  =3D ULP_BITS_2_BYTE_NR(bitpos);
> > -       uint8_t mask;
> > -       int32_t shift;
> > -
> > -       shift =3D ULP_BLOB_BYTE - bitoffs - bitlen;
> > -       if (shift >=3D 0) {
> > -               mask =3D 0xFF >> -bitlen;
> > -               *dst =3D (src[index] >> shift) & mask;
> > -       } else {
> > -               *dst =3D (src[index] & (0xFF >> bitoffs)) << -shift;
> > -               *dst |=3D src[index + 1] >> -shift;
> > -       }
> > -}
> > -
> > -/*
> > - * Get data from the byte array in Big endian format.
> > - *
> > - * src [in] The byte array where data is extracted from
> > - *
> > - * dst [out] The byte array where data is pulled into
> > - *
> > - * offset [in] The offset where data is pulled
> > - *
> > - * len [in] The number of bits to be extracted from the data array
> > - *
> > - * returns None.
> > - */
> > -void
> > -ulp_bs_pull_msb(uint8_t *src, uint8_t *dst,
> > -               uint32_t offset, uint32_t len)
> > -{
> > -       uint32_t idx;
> > -       uint32_t cnt =3D ULP_BITS_2_BYTE_NR(len);
> > -
> > -       /* iterate bytewise to get data */
> > -       for (idx =3D 0; idx < cnt; idx++) {
> > -               ulp_bs_get_msb(src, offset, ULP_BLOB_BYTE, &dst[idx]);
> > -               offset +=3D ULP_BLOB_BYTE;
> > -               len -=3D ULP_BLOB_BYTE;
> > -       }
> > -
> > -       /* Extract the last reminder data that is not 8 byte boundary *=
/
> > -       if (len)
> > -               ulp_bs_get_msb(src, offset, len, &dst[idx]);
> > -}
> > -
> > -/*
> > - * Extract data from the binary blob using given offset.
> > - *
> > - * blob [in] The blob that data is extracted from. The blob must
> > - * be initialized prior to pulling data.
> > - *
> > - * data [in] A pointer to put the data.
> > - * data_size [in] size of the data buffer in bytes.
> > - *offset [in] - Offset in the blob to extract the data in bits format.
> > - * len [in] The number of bits to be pulled from the blob.
> > - *
> > - * Output: zero on success, -1 on failure
> > - */
> > -int32_t
> > -ulp_blob_pull(struct ulp_blob *blob, uint8_t *data, uint32_t data_size=
,
> > -             uint16_t offset, uint16_t len)
> > -{
> > -       /* validate the arguments */
> > -       if (!blob || (offset + len) > blob->bitlen ||
> > -           ULP_BYTE_2_BITS(data_size) < len) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> > -               return -1; /* failure */
> > -       }
> > -
> > -       if (blob->byte_order =3D=3D BNXT_ULP_BYTE_ORDER_BE)
> > -               ulp_bs_pull_msb(blob->data, data, offset, len);
> > -       else
> > -               ulp_bs_pull_lsb(blob->data, data, data_size, offset,
len);
> > -       return 0;
> > -}
> > -
> > -/*
> > - * Get the data portion of the binary blob.
> > - *
> > - * blob [in] The blob's data to be retrieved. The blob must be
> > - * initialized prior to pushing data.
> > - *
> > - * datalen [out] The number of bits that are filled.
> > - *
> > - * Returns a byte array of the blob data or NULL on error.
> > - */
> > -uint8_t *
> > -ulp_blob_data_get(struct ulp_blob *blob,
> > -                 uint16_t *datalen)
> > -{
> > -       /* validate the arguments */
> > -       if (!blob) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> > -               return NULL; /* failure */
> > -       }
> > -       *datalen =3D blob->write_idx;
> > -       return blob->data;
> > -}
> > -
> > -/*
> > - * Get the data length of the binary blob.
> > - *
> > - * blob [in] The blob's data len to be retrieved.
> > - *
> > - * returns length of the binary blob
> > - */
> > -uint16_t
> > -ulp_blob_data_len_get(struct ulp_blob *blob)
> > -{
> > -       /* validate the arguments */
> > -       if (!blob) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> > -               return 0; /* failure */
> > -       }
> > -       return blob->write_idx;
> > -}
> > -
> > -/*
> > - * Set the encap swap start index of the binary blob.
> > - *
> > - * blob [in] The blob's data to be retrieved. The blob must be
> > - * initialized prior to pushing data.
> > - *
> > - * returns void.
> > - */
> > -void
> > -ulp_blob_encap_swap_idx_set(struct ulp_blob *blob)
> > -{
> > -       /* validate the arguments */
> > -       if (!blob) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> > -               return; /* failure */
> > -       }
> > -       blob->encap_swap_idx =3D blob->write_idx;
> > -}
> > -
> > -/*
> > - * Perform the encap buffer swap to 64 bit reversal.
> > - *
> > - * blob [in] The blob's data to be used for swap.
> > - *
> > - * returns void.
> > - */
> > -void
> > -ulp_blob_perform_encap_swap(struct ulp_blob *blob)
> > -{
> > -       uint32_t i, idx =3D 0, end_idx =3D 0, roundoff;
> > -       uint8_t temp_val_1, temp_val_2;
> > -
> > -       /* validate the arguments */
> > -       if (!blob) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> > -               return; /* failure */
> > -       }
> > -       idx =3D ULP_BITS_2_BYTE_NR(blob->encap_swap_idx);
> > -       end_idx =3D ULP_BITS_2_BYTE(blob->write_idx);
> > -       roundoff =3D ULP_BYTE_2_BITS(ULP_BITS_2_BYTE(end_idx));
> > -       if (roundoff > end_idx) {
> > -               blob->write_idx +=3D ULP_BYTE_2_BITS(roundoff - end_idx=
);
> > -               end_idx =3D roundoff;
> > -       }
> > -       while (idx <=3D end_idx) {
> > -               for (i =3D 0; i < 4; i =3D i + 2) {
> > -                       temp_val_1 =3D blob->data[idx + i];
> > -                       temp_val_2 =3D blob->data[idx + i + 1];
> > -                       blob->data[idx + i] =3D blob->data[idx + 6 - i]=
;
> > -                       blob->data[idx + i + 1] =3D blob->data[idx + 7 =
-
i];
> > -                       blob->data[idx + 7 - i] =3D temp_val_2;
> > -                       blob->data[idx + 6 - i] =3D temp_val_1;
> > -               }
> > -               idx +=3D 8;
> > -       }
> > -}
> > -
> > -/*
> > - * Perform the blob buffer reversal byte wise.
> > - * This api makes the first byte the last and
> > - * vice-versa.
> > - *
> > - * blob [in] The blob's data to be used for swap.
> > - * chunk_size[in] the swap is done within the chunk in bytes
> > - *
> > - * returns void.
> > - */
> > -void
> > -ulp_blob_perform_byte_reverse(struct ulp_blob *blob,
> > -                             uint32_t chunk_size)
> > -{
> > -       uint32_t idx =3D 0, jdx =3D 0, num =3D 0;
> > -       uint8_t xchar;
> > -       uint8_t *buff;
> > -
> > -       /* validate the arguments */
> > -       if (!blob) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> > -               return; /* failure */
> > -       }
> > -
> > -       buff =3D blob->data;
> > -       num =3D ULP_BITS_2_BYTE(blob->write_idx) / chunk_size;
> > -       for (idx =3D 0; idx < num; idx++) {
> > -               for (jdx =3D 0; jdx < chunk_size / 2; jdx++) {
> > -                       xchar =3D buff[jdx];
> > -                       buff[jdx] =3D buff[(chunk_size - 1) - jdx];
> > -                       buff[(chunk_size - 1) - jdx] =3D xchar;
> > -               }
> > -               buff +=3D chunk_size;
> > -       }
> > -}
> > -
> > -/*
> > - * Perform the blob buffer 64 bit word swap.
> > - * This api makes the first 4 bytes the last in
> > - * a given 64 bit value and vice-versa.
> > - *
> > - * blob [in] The blob's data to be used for swap.
> > - *
> > - * returns void.
> > - */
> > -void
> > -ulp_blob_perform_64B_word_swap(struct ulp_blob *blob)
> > -{
> > -       uint32_t i, j, num;
> > -       uint8_t xchar;
> > -       uint32_t word_size =3D ULP_64B_IN_BYTES / 2;
> > -
> > -       /* validate the arguments */
> > -       if (!blob) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> > -               return; /* failure */
> > -       }
> > -       num =3D ULP_BITS_2_BYTE(blob->write_idx);
> > -       for (i =3D 0; i < num; i =3D i + ULP_64B_IN_BYTES) {
> > -               for (j =3D 0; j < word_size; j++) {
> > -                       xchar =3D blob->data[i + j];
> > -                       blob->data[i + j] =3D blob->data[i + j +
word_size];
> > -                       blob->data[i + j + word_size] =3D xchar;
> > -               }
> > -       }
> > -}
> > -
> > -/*
> > - * Perform the blob buffer 64 bit byte swap.
> > - * This api makes the first byte the last in
> > - * a given 64 bit value and vice-versa.
> > - *
> > - * blob [in] The blob's data to be used for swap.
> > - *
> > - * returns void.
> > - */
> > -void
> > -ulp_blob_perform_64B_byte_swap(struct ulp_blob *blob)
> > -{
> > -       uint32_t i, j, num;
> > -       uint8_t xchar;
> > -       uint32_t offset =3D ULP_64B_IN_BYTES - 1;
> > -
> > -       /* validate the arguments */
> > -       if (!blob) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> > -               return; /* failure */
> > -       }
> > -       num =3D ULP_BITS_2_BYTE(blob->write_idx);
> > -       for (i =3D 0; i < num; i =3D i + ULP_64B_IN_BYTES) {
> > -               for (j =3D 0; j < (ULP_64B_IN_BYTES / 2); j++) {
> > -                       xchar =3D blob->data[i + j];
> > -                       blob->data[i + j] =3D blob->data[i + offset - j=
];
> > -                       blob->data[i + offset - j] =3D xchar;
> > -               }
> > -       }
> > -}
> > -
> > -static int32_t
> > -ulp_blob_msb_block_merge(struct ulp_blob *dst, struct ulp_blob *src,
> > -                        uint32_t block_size, uint32_t pad)
> > -{
> > -       uint32_t i, k, write_bytes, remaining;
> > -       uint16_t num;
> > -       uint8_t *src_buf =3D ulp_blob_data_get(src, &num);
> > -       uint8_t bluff;
> > -
> > -       for (i =3D 0; i < num;) {
> > -               if (((dst->write_idx % block_size) + (num - i)) >
block_size)
> > -                       write_bytes =3D block_size -
> > -                               (dst->write_idx % block_size);
> > -               else
> > -                       write_bytes =3D num - i;
> > -               for (k =3D 0; k < ULP_BITS_2_BYTE_NR(write_bytes); k++)=
 {
> > -                       ulp_bs_put_msb(dst->data, dst->write_idx,
ULP_BLOB_BYTE,
> > -                                      *src_buf);
> > -                       dst->write_idx +=3D ULP_BLOB_BYTE;
> > -                       src_buf++;
> > -               }
> > -               remaining =3D write_bytes % ULP_BLOB_BYTE;
> > -               if (remaining) {
> > -                       bluff =3D (*src_buf) & ((uint8_t)-1 <<
> > -                                             (ULP_BLOB_BYTE -
remaining));
> > -                       ulp_bs_put_msb(dst->data, dst->write_idx,
> > -                                      ULP_BLOB_BYTE, bluff);
> > -                       dst->write_idx +=3D remaining;
> > -               }
> > -               if (write_bytes !=3D (num - i)) {
> > -                       /* add the padding */
> > -                       ulp_blob_pad_push(dst, pad);
> > -                       if (remaining) {
> > -                               ulp_bs_put_msb(dst->data,
dst->write_idx,
> > -                                              ULP_BLOB_BYTE -
remaining,
> > -                                              *src_buf);
> > -                               dst->write_idx +=3D ULP_BLOB_BYTE -
remaining;
> > -                               src_buf++;
> > -                       }
> > -               }
> > -               i +=3D write_bytes;
> > -       }
> > -       return 0;
> > -}
> > -
> > -/*
> > - * Perform the blob buffer merge.
> > - * This api makes the src blob merged to the dst blob.
> > - * The block size and pad size help in padding the dst blob
> > - *
> > - * dst [in] The destination blob, the blob to be merged.
> > - * src [in] The src blob.
> > - * block_size [in] The size of the block in bytes after which padding
gets
> > - *                 applied.
> > - * pad [in] The size of the pad to be applied.
> > - *
> > - * returns 0 on success.
> > - */
> > -int32_t
> > -ulp_blob_block_merge(struct ulp_blob *dst, struct ulp_blob *src,
> > -                    uint32_t block_size, uint32_t pad)
> > -{
> > -       if (dst->byte_order =3D=3D BNXT_ULP_BYTE_ORDER_BE &&
> > -           src->byte_order =3D=3D BNXT_ULP_BYTE_ORDER_BE)
> > -               return ulp_blob_msb_block_merge(dst, src, block_size,
pad);
> > -
> > -       BNXT_DRV_DBG(ERR, "block merge not implemented yet\n");
> > -       return -EINVAL;
> > -}
> > -
> > -int32_t
> > -ulp_blob_append(struct ulp_blob *dst, struct ulp_blob *src,
> > -               uint16_t src_offset, uint16_t src_len)
> > -{
> > -       uint32_t k, remaining =3D 0;
> > -       uint16_t num;
> > -       uint8_t bluff;
> > -       uint8_t *src_buf =3D ulp_blob_data_get(src, &num);
> > -
> > -       if ((src_offset + src_len) > num)
> > -               return -EINVAL;
> > -
> > -       /* Only supporting BE for now */
> > -       if (src->byte_order !=3D BNXT_ULP_BYTE_ORDER_BE ||
> > -           dst->byte_order !=3D BNXT_ULP_BYTE_ORDER_BE)
> > -               return -EINVAL;
> > -
> > -       /* Handle if the source offset is not on a byte boundary */
> > -       remaining =3D src_offset % ULP_BLOB_BYTE;
> > -       if (remaining) {
> > -               bluff =3D src_buf[src_offset / ULP_BLOB_BYTE] &
((uint8_t)-1 >>
> > -                                     (ULP_BLOB_BYTE - remaining));
> > -               ulp_bs_put_msb(dst->data, dst->write_idx,
> > -                              ULP_BLOB_BYTE, bluff);
> > -               dst->write_idx +=3D remaining;
> > -               src_offset +=3D remaining;
> > -       }
> > -
> > -       src_buf +=3D ULP_BITS_2_BYTE_NR(src_offset);
> > -
> > -       /* Push the byte aligned pieces */
> > -       for (k =3D 0; k < ULP_BITS_2_BYTE_NR(src_len); k++) {
> > -               ulp_bs_put_msb(dst->data, dst->write_idx, ULP_BLOB_BYTE=
,
> > -                              *src_buf);
> > -               dst->write_idx +=3D ULP_BLOB_BYTE;
> > -               src_buf++;
> > -       }
> > -
> > -       /* Handle the remaining if length is not a byte boundary */
> > -       if (src_len > remaining)
> > -               remaining =3D (src_len - remaining) % ULP_BLOB_BYTE;
> > -       else
> > -               remaining =3D 0;
> > -       if (remaining) {
> > -               bluff =3D (*src_buf) & ((uint8_t)-1 <<
> > -                                     (ULP_BLOB_BYTE - remaining));
> > -               ulp_bs_put_msb(dst->data, dst->write_idx,
> > -                              ULP_BLOB_BYTE, bluff);
> > -               dst->write_idx +=3D remaining;
> > -       }
> > -
> > -       return 0;
> > -}
> > -
> > -/*
> > - * Perform the blob buffer copy.
> > - * This api makes the src blob merged to the dst blob.
> > - *
> > - * dst [in] The destination blob, the blob to be merged.
> > - * src [in] The src blob.
> > - *
> > - * returns 0 on success.
> > - */
> > -int32_t
> > -ulp_blob_buffer_copy(struct ulp_blob *dst, struct ulp_blob *src)
> > -{
> > -       if ((dst->write_idx + src->write_idx) > dst->bitlen) {
> > -               BNXT_DRV_DBG(ERR, "source buffer too large\n");
> > -               return -EINVAL;
> > -       }
> > -       if (ULP_BITS_IS_BYTE_NOT_ALIGNED(dst->write_idx) ||
> > -           ULP_BITS_IS_BYTE_NOT_ALIGNED(src->write_idx)) {
> > -               BNXT_DRV_DBG(ERR, "source buffer is not aligned\n");
> > -               return -EINVAL;
> > -       }
> > -       memcpy(&dst->data[ULP_BITS_2_BYTE_NR(dst->write_idx)],
> > -              src->data, ULP_BITS_2_BYTE_NR(src->write_idx));
> > -       dst->write_idx +=3D src->write_idx;
> > -       return 0;
> > -}
> > -
> > -/*
> > - * Read data from the operand
> > - *
> > - * operand [in] A pointer to a 16 Byte operand
> > - *
> > - * val [in/out] The variable to copy the operand to
> > - *
> > - * bytes [in] The number of bytes to read into val
> > - *
> > - * returns zero on success.
> > - */
> > -int32_t
> > -ulp_operand_read(uint8_t *operand,
> > -                uint8_t *val,
> > -                uint16_t bytes)
> > -{
> > -       /* validate the arguments */
> > -       if (!operand || !val) {
> > -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> > -               return -EINVAL;
> > -       }
> > -       memcpy(val, operand, bytes);
> > -       return 0;
> > -}
> > -
> > -/*
> > - * Check the buffer is empty
> > - *
> > - * buf [in] The buffer
> > - * size [in] The size of the buffer
> > - *
> > - */
> > -int32_t ulp_buffer_is_empty(const uint8_t *buf, uint32_t size)
> > -{
> > -       return buf[0] =3D=3D 0 && !memcmp(buf, buf + 1, size - 1);
> > -}
> > -
> > -/* Function to check if bitmap is zero.Return 1 on success */
> > -uint32_t ulp_bitmap_is_zero(uint8_t *bitmap, int32_t size)
> > -{
> > -       while (size-- > 0) {
> > -               if (*bitmap !=3D 0)
> > -                       return 0;
> > -               bitmap++;
> > -       }
> > -       return 1;
> > -}
> > -
> > -/* Function to check if bitmap is ones. Return 1 on success */
> > -uint32_t ulp_bitmap_is_ones(uint8_t *bitmap, int32_t size)
> > -{
> > -       while (size-- > 0) {
> > -               if (*bitmap !=3D 0xFF)
> > -                       return 0;
> > -               bitmap++;
> > -       }
> > -       return 1;
> > -}
> > -
> > -/* Function to check if bitmap is not zero. Return 1 on success */
> > -uint32_t ulp_bitmap_notzero(const uint8_t *bitmap, int32_t size)
> > -{
> > -       while (size-- > 0) {
> > -               if (*bitmap !=3D 0)
> > -                       return 1;
> > -               bitmap++;
> > -       }
> > -       return 0;
> > -}
> > -
> > -/* returns 0 if input is power of 2 */
> > -int32_t ulp_util_is_power_of_2(uint64_t x)
> > -{
> > -       if (((x - 1) & x))
> > -               return -1;
> > -       return 0;
> > -}
> > --
> > 2.51.0
> >

--000000000000ec98e2064c293814
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Nov 21, 2025 at 2:24=E2=80=AFPM Ajit Khapa=
rde &lt;<a href=3D"mailto:ajit.khaparde@broadcom.com">ajit.khaparde@broadco=
m.com</a>&gt; wrote:<br>&gt;<br>&gt; On Fri, Nov 14, 2025 at 9:51=E2=80=AFA=
M Stephen Hemminger<br>&gt; &lt;<a href=3D"mailto:stephen@networkplumber.or=
g">stephen@networkplumber.org</a>&gt; wrote:<br>&gt; &gt;<br>&gt; &gt; Seve=
ral C files are never used or built.<br>&gt; &gt; Looks like they were conv=
erted to header files but the old source<br>&gt; &gt; was never removed.<br=
>&gt; &gt;<br>&gt; &gt; Fixes: aa49b38fa7c3 (&quot;net/bnxt/tf_core: cleanu=
p external EM support&quot;)<br>&gt; &gt; Cc: <a href=3D"mailto:shuanglin.w=
ang@broadcom.com">shuanglin.wang@broadcom.com</a><br>&gt; &gt;<br>&gt; &gt;=
 Signed-off-by: Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplum=
ber.org">stephen@networkplumber.org</a>&gt;<br>&gt; Acked-by: Ajit Khaparde=
 &lt;<a href=3D"mailto:ajit.khaparde@broadcom.com">ajit.khaparde@broadcom.c=
om</a>&gt;<div>Acked-by: Kishore Padmanabha&lt;<a href=3D"mailto:kishore.pa=
dmanabha@broadcom.com">kishore.padmanabha@broadcom.com</a>&gt;<br>&gt;<br>&=
gt; &gt; ---<br>&gt; &gt; =C2=A0.../net/bnxt/tf_core/cfa_tcam_mgr_session.c=
 =C2=A0 | =C2=A0390 ------<br>&gt; &gt; =C2=A0drivers/net/bnxt/tf_core/tf_e=
m_common.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 23 -<br>&gt; &gt; =C2=A0drivers/ne=
t/bnxt/tf_core/tf_em_host.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 23 -<br>&g=
t; &gt; =C2=A0drivers/net/bnxt/tf_ulp/ulp_utils.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 1100 -----------------<br>&gt; &gt; =C2=A04 files changed, 153=
6 deletions(-)<br>&gt; &gt; =C2=A0delete mode 100644 drivers/net/bnxt/tf_co=
re/cfa_tcam_mgr_session.c<br>&gt; &gt; =C2=A0delete mode 100644 drivers/net=
/bnxt/tf_core/tf_em_common.c<br>&gt; &gt; =C2=A0delete mode 100644 drivers/=
net/bnxt/tf_core/tf_em_host.c<br>&gt; &gt; =C2=A0delete mode 100644 drivers=
/net/bnxt/tf_ulp/ulp_utils.c<br>&gt; &gt;<br>&gt; &gt; diff --git a/drivers=
/net/bnxt/tf_core/cfa_tcam_mgr_session.c b/drivers/net/bnxt/tf_core/cfa_tca=
m_mgr_session.c<br>&gt; &gt; deleted file mode 100644<br>&gt; &gt; index 40=
bbcc54c8..0000000000<br>&gt; &gt; --- a/drivers/net/bnxt/tf_core/cfa_tcam_m=
gr_session.c<br>&gt; &gt; +++ /dev/null<br>&gt; &gt; @@ -1,390 +0,0 @@<br>&=
gt; &gt; -/* SPDX-License-Identifier: BSD-3-Clause<br>&gt; &gt; - * Copyrig=
ht(c) 2021-2023 Broadcom<br>&gt; &gt; - * All rights reserved.<br>&gt; &gt;=
 - */<br>&gt; &gt; -<br>&gt; &gt; -#include &lt;inttypes.h&gt;<br>&gt; &gt;=
 -#include &quot;hcapi_cfa_defs.h&quot;<br>&gt; &gt; -#include &quot;tf_uti=
l.h&quot;<br>&gt; &gt; -#include &quot;cfa_tcam_mgr.h&quot;<br>&gt; &gt; -#=
include &quot;cfa_tcam_mgr_device.h&quot;<br>&gt; &gt; -#include &quot;cfa_=
tcam_mgr_session.h&quot;<br>&gt; &gt; -#include &quot;cfa_tcam_mgr_sbmp.h&q=
uot;<br>&gt; &gt; -#include &quot;tfp.h&quot;<br>&gt; &gt; -#include &quot;=
cfa_tcam_mgr_p58.h&quot;<br>&gt; &gt; -#include &quot;cfa_tcam_mgr_p4.h&quo=
t;<br>&gt; &gt; -<br>&gt; &gt; -struct cfa_tcam_mgr_session_data {<br>&gt; =
&gt; - =C2=A0 =C2=A0 =C2=A0 uint32_t session_id;<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 /* The following are per-session values */<br>&gt; &gt; - =C2=A0=
 =C2=A0 =C2=A0 uint16_t max_entries[TF_DIR_MAX][CFA_TCAM_MGR_TBL_TYPE_MAX];=
<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint16_t used_entries[TF_DIR_MAX][CFA_=
TCAM_MGR_TBL_TYPE_MAX];<br>&gt; &gt; -};<br>&gt; &gt; -<br>&gt; &gt; -stati=
c struct cfa_tcam_mgr_session_data session_data[TF_TCAM_MAX_SESSIONS];<br>&=
gt; &gt; -<br>&gt; &gt; -static uint16_t last_entry_id;<br>&gt; &gt; -<br>&=
gt; &gt; -static struct sbmp *session_bmp[TF_TCAM_MAX_SESSIONS];<br>&gt; &g=
t; -<br>&gt; &gt; -int<br>&gt; &gt; -cfa_tcam_mgr_session_init(int sess_idx=
, enum cfa_tcam_mgr_device_type type)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0=
 =C2=A0 =C2=A0 int rc;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 s=
witch (type) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 case CFA_TCAM_MGR_DEVICE=
_TYPE_P4:<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 case CFA_TCAM_MGR_DEVICE_TYPE=
_SR:<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D=
 cfa_tcam_mgr_sess_table_get_p4(sess_idx, &amp;session_bmp[sess_idx]);<br>&=
gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>&gt; =
&gt; - =C2=A0 =C2=A0 =C2=A0 case CFA_TCAM_MGR_DEVICE_TYPE_P5:<br>&gt; &gt; =
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D cfa_tcam_mgr_sess=
_table_get_p58(sess_idx, &amp;session_bmp[sess_idx]);<br>&gt; &gt; - =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 default:<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 CFA_TCAM_MGR_LOG(ERR, &quot;No such device %d\n&quot;, type);<br=
>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D -CFA_T=
CAM_MGR_ERR_CODE(NODEV);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt;=
 -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return rc;<br>&gt; &gt; -}<br>&gt; &=
gt; -<br>&gt; &gt; -int<br>&gt; &gt; -cfa_tcam_mgr_get_session_from_context=
(struct cfa_tcam_mgr_context *context,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *session_id)<br>&gt; &gt; -{<br>&g=
t; &gt; - =C2=A0 =C2=A0 =C2=A0 if (context =3D=3D NULL) {<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CFA_TCAM_MGR_LOG_0(ERR, &q=
uot;context passed as NULL pointer.\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -CFA_TCAM_MGR_ERR_CODE(INVAL);<br=
>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 *session_id =3D context-&gt;tfp-&gt;session-&gt;<a href=3D"ht=
tp://session_id.id">session_id.id</a>;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
return 0;<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -int<br>&gt; &gt; -cf=
a_tcam_mgr_session_find(unsigned int session_id)<br>&gt; &gt; -{<br>&gt; &g=
t; - =C2=A0 =C2=A0 =C2=A0 unsigned int sess_idx;<br>&gt; &gt; -<br>&gt; &gt=
; - =C2=A0 =C2=A0 =C2=A0 for (sess_idx =3D 0; sess_idx &lt; ARRAY_SIZE(sess=
ion_data); sess_idx++) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (session_data[sess_idx].session_id =3D=3D session_id)<br>&=
gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return sess_idx;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt=
; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return -CFA_TCAM_MGR_ERR_CODE(=
INVAL);<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -int<br>&gt; &gt; -cfa_=
tcam_mgr_session_empty(void)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 unsigned int sess_idx;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 for (sess_idx =3D 0; sess_idx &lt; ARRAY_SIZE(session_data); sess_id=
x++) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
session_data[sess_idx].session_id)<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>&gt; &gt;=
 - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 return 1;<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -int<br>&gt; &gt;=
 -cfa_tcam_mgr_session_add(unsigned int session_id)<br>&gt; &gt; -{<br>&gt;=
 &gt; - =C2=A0 =C2=A0 =C2=A0 int sess_idx;<br>&gt; &gt; -<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 sess_idx =3D cfa_tcam_mgr_session_find(session_id);<br=
>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (sess_idx &gt;=3D 0) {<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CFA_TCAM_MGR_LOG_0(ERR, &q=
uot;Session is already bound.\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -CFA_TCAM_MGR_ERR_CODE(BUSY);<br>&gt; &=
gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 /* Session not found in table, find first empty entry. */<br>&gt; &g=
t; - =C2=A0 =C2=A0 =C2=A0 for (sess_idx =3D 0;<br>&gt; &gt; - =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0sess_idx &lt; (signed int)ARRAY_SIZE(session_da=
ta);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sess_idx++) {<=
br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (session=
_data[sess_idx].session_id =3D=3D 0)<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>&gt; &gt;=
 - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 if (sess_idx &gt;=3D (signed int)ARRAY_SIZE(session_data)) {<br>&gt; &g=
t; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* No room in the ses=
sion table */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 CFA_TCAM_MGR_LOG_0(ERR, &quot;Session table is full.\n&quot;);<br>&gt; =
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -CFA_TCAM_MG=
R_ERR_CODE(NOMEM);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>=
&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 session_data[sess_idx].session_id =3D sess=
ion_id;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return sess_idx;=
<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -int<br>&gt; &gt; -cfa_tcam_mg=
r_session_free(unsigned int session_id,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cfa_tcam_mgr_context *context)<br>&gt; =
&gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 struct cfa_tcam_mgr_free_parms =
free_parms;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 int entry_id;<br>&gt; &gt; =
- =C2=A0 =C2=A0 =C2=A0 int sess_idx =3D cfa_tcam_mgr_session_find(session_i=
d);<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (sess_idx &lt; 0)=
<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ses=
s_idx;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 memset(&amp;free_=
parms, 0, sizeof(free_parms));<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 /* Since=
 we are freeing all pending TCAM entries (which is typically<br>&gt; &gt; -=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0* done during tcam_unbind), we don&#39;t know t=
he type of each entry.<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0* So we se=
t the type to MAX as a hint to cfa_tcam_mgr_free() to<br>&gt; &gt; - =C2=A0=
 =C2=A0 =C2=A0 =C2=A0* figure out the actual type. We need to set it throug=
h each<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0* iteration in the loop be=
low; otherwise, the type determined for<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0=
 =C2=A0* the first entry would be used for subsequent entries that may or<b=
r>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0* may not be of the same type, res=
ulting in errors.<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>&gt; &gt;=
 - =C2=A0 =C2=A0 =C2=A0 for (entry_id =3D 0; entry_id &lt; cfa_tcam_mgr_max=
_entries[sess_idx]; entry_id++) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (SBMP_MEMBER(session_bmp[sess_idx][entry_id], s=
ess_idx)) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SBMP_SESSION_REMOVE(session_bmp[sess_idx][entr=
y_id], sess_idx);<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://free_pa=
rms.id">free_parms.id</a> =3D entry_id;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free_parms.type =
=3D CFA_TCAM_MGR_TBL_TYPE_MAX;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cfa_tcam_mgr_free(context,=
 &amp;free_parms);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt;=
 - =C2=A0 =C2=A0 =C2=A0 memset(&amp;session_data[sess_idx], 0, sizeof(sessi=
on_data[sess_idx]));<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return 0;<br>&gt; =
&gt; -}<br>&gt; &gt; -<br>&gt; &gt; -int<br>&gt; &gt; -cfa_tcam_mgr_session=
_cfg(unsigned int session_id,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t tcam_cnt[][=
CFA_TCAM_MGR_TBL_TYPE_MAX])<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 struct cfa_tcam_mgr_table_data *table_data;<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 struct cfa_tcam_mgr_session_data *session_entry;<br>&gt; &gt;=
 - =C2=A0 =C2=A0 =C2=A0 unsigned int dir, type;<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 int sess_idx =3D cfa_tcam_mgr_session_find(session_id);<br>&gt; =
&gt; - =C2=A0 =C2=A0 =C2=A0 uint16_t requested_cnt;<br>&gt; &gt; -<br>&gt; =
&gt; - =C2=A0 =C2=A0 =C2=A0 if (sess_idx &lt; 0)<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return sess_idx;<br>&gt; &gt; -<br>&=
gt; &gt; - =C2=A0 =C2=A0 =C2=A0 session_entry =3D &amp;session_data[sess_id=
x];<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 /* Validate session =
request */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 for (dir =3D 0; dir &lt; ARR=
AY_SIZE(cfa_tcam_mgr_tables[sess_idx]); dir++) {<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (type =3D 0;<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type &lt;=
 ARRAY_SIZE(cfa_tcam_mgr_tables[sess_idx][dir]);<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type++) {<br>&gt=
; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 table_data =3D &amp;cfa_tcam_mgr_tables[sess_idx][dir][type];<br=
>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 requested_cnt =3D tcam_cnt[dir][type];<br>&gt; &gt; - =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<b=
r>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0* Only check if table supported (max_entries &gt; 0=
).<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (table_data-&gt;max_ent=
ries &gt; 0 &amp;&amp;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 requested_cnt &gt; =
table_data-&gt;max_entries) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 CFA_TCAM_MGR_LOG_DIR_TYPE(ERR, dir, type,<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot;Requested %d, available %d.\n&quot;,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reque=
sted_cnt,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 table_data-&gt;max_entries);<br>&gt;=
 &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -CFA_TCAM_MGR_ERR_CODE(NOSPC)=
;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt=
; &gt; - =C2=A0 =C2=A0 =C2=A0 memcpy(session_entry-&gt;max_entries, tcam_cn=
t,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(se=
ssion_entry-&gt;max_entries));<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return 0=
;<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -void<br>&gt; &gt; -cfa_tcam_=
mgr_mv_session_used_entries_cnt(int sess_idx, enum tf_dir dir,<br>&gt; &gt;=
 - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum c=
fa_tcam_mgr_tbl_type dst_type,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum cfa_tcam_mgr_tbl_type src_type)<=
br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 session_data[sess_idx].=
used_entries[dir][dst_type]++;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 session_=
data[sess_idx].used_entries[dir][src_type]--;<br>&gt; &gt; -}<br>&gt; &gt; =
-<br>&gt; &gt; -int<br>&gt; &gt; -cfa_tcam_mgr_session_entry_alloc(unsigned=
 int session_id,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum t=
f_dir dir,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum cfa_tcam=
_mgr_tbl_type type)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 int=
 sess_idx;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 sess_idx =3D =
cfa_tcam_mgr_session_find(session_id);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
if (sess_idx &lt; 0) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 CFA_TCAM_MGR_LOG_0(ERR, &quot;Session not found.\n&quot;);<br=
>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -CFA_T=
CAM_MGR_ERR_CODE(NODEV);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt;=
 -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (session_data[sess_idx].used_entr=
ies[dir][type] &gt;=3D<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 se=
ssion_data[sess_idx].max_entries[dir][type]) {<br>&gt; &gt; - =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CFA_TCAM_MGR_LOG_0(ERR, &quot;Table ful=
l (session).\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return -CFA_TCAM_MGR_ERR_CODE(NOSPC);<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 do {<br>=
&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_entry_id+=
+;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cfa_=
tcam_mgr_max_entries[sess_idx] &lt;=3D last_entry_id)<br>&gt; &gt; - =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last=
_entry_id =3D 0;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 } while (!SBMP_IS_NULL=
(session_bmp[sess_idx][last_entry_id]));<br>&gt; &gt; -<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 SBMP_SESSION_ADD(session_bmp[sess_idx][last_entry_id], se=
ss_idx);<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 session_data[se=
ss_idx].used_entries[dir][type] +=3D 1;<br>&gt; &gt; -<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 return last_entry_id;<br>&gt; &gt; -}<br>&gt; &gt; -<br>&=
gt; &gt; -int<br>&gt; &gt; -cfa_tcam_mgr_session_entry_free(unsigned int se=
ssion_id,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int entry_=
id,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum tf_dir dir,<br>&gt; &=
gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum cfa_tcam_mgr_tbl_type type)<br>&gt=
; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 int sess_idx;<br>&gt; &gt; -<=
br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 sess_idx =3D cfa_tcam_mgr_session_find(=
session_id);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (sess_idx &lt; 0) {<br>=
&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CFA_TCAM_MGR_L=
OG_0(ERR, &quot;Session not found.\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -CFA_TCAM_MGR_ERR_CODE(NODEV);<br=
>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 SBMP_SESSION_REMOVE(session_bmp[sess_idx][entry_id], sess_idx=
);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 session_data[sess_idx].used_entries[=
dir][type] -=3D 1;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 retur=
n 0;<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -#if SBMP_WORD_WIDTH =3D=
=3D 16<br>&gt; &gt; -#define SBMP_FORMAT PRIX16<br>&gt; &gt; -#define SBMP_=
PRECISION &quot;4&quot;<br>&gt; &gt; -#elif SBMP_WORD_WIDTH =3D=3D 32<br>&g=
t; &gt; -#define SBMP_FORMAT PRIX32<br>&gt; &gt; -#define SBMP_PRECISION &q=
uot;8&quot;<br>&gt; &gt; -#elif SBMP_WORD_WIDTH =3D=3D 64<br>&gt; &gt; -#de=
fine SBMP_FORMAT PRIX64<br>&gt; &gt; -#define SBMP_PRECISION &quot;16&quot;=
<br>&gt; &gt; -#else<br>&gt; &gt; -#error &quot;Invalid value for SBMP_WORD=
_WIDTH.&quot;<br>&gt; &gt; -#endif<br>&gt; &gt; -<br>&gt; &gt; -static void=
<br>&gt; &gt; -cfa_tcam_mgr_session_bitmap_print(struct sbmp *session_bmp)<=
br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 unsigned int i;<br>&gt;=
 &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 printf(&quot;0x&quot;);<br>&gt;=
 &gt; - =C2=A0 =C2=A0 =C2=A0 for (i =3D 0;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0i &lt; ARRAY_SIZE(session_bmp-&gt;bits);<br>&gt; &g=
t; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i++) {<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;%0&quot; SBMP_PRECIS=
ION SBMP_FORMAT,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0session_bmp-&gt;bits[i]);<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -#define=
 SESSION_DUMP_HEADER_1 &quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RX =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0TX\n&quot;<br>&gt; &gt; -#define SESSION_DUMP_HEADER_2 \<b=
r>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 &quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Max =C2=A0 Used =C2=A0=
Max =C2=A0 Used\n&quot;<br>&gt; &gt; -<br>&gt; &gt; -static void<br>&gt; &g=
t; -cfa_tcam_mgr_session_printf(struct cfa_tcam_mgr_session_data *session,<=
br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum cfa_tcam_mgr_tbl_type tbl_type)<br>&gt=
; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 printf(&quot;%-22s: %5u %5u %=
5u %5u\n&quot;,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0cfa_tcam_mgr_tbl_2_str(tbl_type),<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0session-&gt;max_entries[TF_DIR_RX][tbl_type],<b=
r>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0session-&gt;u=
sed_entries[TF_DIR_RX][tbl_type],<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0session-&gt;max_entries[TF_DIR_TX][tbl_type],<br>&g=
t; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0session-&gt;used_=
entries[TF_DIR_TX][tbl_type]);<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; =
-void<br>&gt; &gt; -cfa_tcam_mgr_sessions_dump(void)<br>&gt; &gt; -{<br>&gt=
; &gt; - =C2=A0 =C2=A0 =C2=A0 struct cfa_tcam_mgr_session_data *session;<br=
>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 unsigned int sess_idx;<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 bool sess_found =3D false;<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 enum cfa_tcam_mgr_tbl_type tbl_type;<br>&gt; &gt; -<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 printf(&quot;\nTCAM Sessions Table:\n&quot;);<br>&gt; =
&gt; - =C2=A0 =C2=A0 =C2=A0 for (sess_idx =3D 0; sess_idx &lt; ARRAY_SIZE(s=
ession_data); sess_idx++) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (session_data[sess_idx].session_id !=3D 0) {<br>&gt; &=
gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 session =3D &amp;session_data[sess_idx];<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ses=
s_found) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(SESSION_DUMP=
_HEADER_1);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(SESSION_DUM=
P_HEADER_2);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;Session 0=
x%08x:\n&quot;,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0session-&gt;s=
ession_id);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (tbl_type =3D CFA_TCAM_MGR_TBL_TYPE_START;=
<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tbl_type &lt; CFA_TCAM_MGR_TBL_TYPE_M=
AX;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tbl_type++) {<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cfa_tcam_mgr_session_printf(session, tbl_type);=
<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sess_found =3D true;<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (!ses=
s_found)<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr=
intf(&quot;No sessions found.\n&quot;);<br>&gt; &gt; -}<br>&gt; &gt; -<br>&=
gt; &gt; -/* This dumps all the sessions using an entry */<br>&gt; &gt; -vo=
id<br>&gt; &gt; -cfa_tcam_mgr_entry_sessions_dump(int sess_idx, uint16_t id=
)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 bool session_found =
=3D false;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (id &gt;=
=3D cfa_tcam_mgr_max_entries[sess_idx]) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;Entry ID %u out of range for s=
ess_idx %d.=C2=A0 Max ID %u.\n&quot;,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0id, sess_idx, cfa_tc=
am_mgr_max_entries[sess_idx] - 1);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&=
gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (!SBMP_IS_NULL(session_bm=
p[sess_idx][id])) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 printf(&quot;Sessions using entry ID %u:\n&quot;, id);<br>&gt; &=
gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (sess_idx =3D 0;=
 sess_idx &lt; SBMP_SESSION_MAX; sess_idx++)<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (SBMP_MEM=
BER(session_bmp[sess_idx][id], (sess_idx))) {<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (session_data[sess_idx].session_id !=3D 0) {<br>&gt; &=
gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quo=
t;0x%08x (index %d)\n&quot;,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 session_data[sess_idx].session_id,<br>&g=
t; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sess_idx);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 session_found =3D true;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 } else {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 printf(&quot;Error! Entry ID %u used by &quot;<br>&gt;=
 &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&quot;session index %d which is not &quot;<br>&gt; &gt;=
 - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;in use.\n&quot;,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0id, sess_=
idx);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }=
<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!sessi=
on_found)<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;No sessions using entry ID %u.\n&q=
uot;, id);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 } else {<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;Entry ID %u not =
in use.\n&quot;,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0id);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<b=
r>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/* This dumps all the entries i=
n use by any session */<br>&gt; &gt; -void<br>&gt; &gt; -cfa_tcam_mgr_sessi=
on_entries_dump(int sess_idx)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 bool entry_found =3D false;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint=
16_t id;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 printf(&quot;\n=
Global Maximum Entries for sess_idx %d: %d\n\n&quot;,<br>&gt; &gt; - =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sess_idx, cfa_tcam_mgr_max_entrie=
s[sess_idx]);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 printf(&quot;TCAM Session=
 Entry Table:\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 for (id =3D 0; =
id &lt; cfa_tcam_mgr_max_entries[sess_idx]; id++) {<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!SBMP_IS_NULL(session_bmp[ses=
s_idx][id])) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!entry_found)<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 printf(&quot; =C2=A0EID Session bitmap\n&quot;);<br>&g=
t; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 printf(&quot;%5u &quot;, id);<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cfa_tcam_mgr=
_session_bitmap_print(&amp;session_bmp[sess_idx][id]);<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p=
rintf(&quot;\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry_found =3D true;<br>&gt; &gt=
; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (=
!entry_found)<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 printf(&quot;No entries found.\n&quot;);<br>&gt; &gt; -}<br>&gt; &gt; d=
iff --git a/drivers/net/bnxt/tf_core/tf_em_common.c b/drivers/net/bnxt/tf_c=
ore/tf_em_common.c<br>&gt; &gt; deleted file mode 100644<br>&gt; &gt; index=
 2449759db0..0000000000<br>&gt; &gt; --- a/drivers/net/bnxt/tf_core/tf_em_c=
ommon.c<br>&gt; &gt; +++ /dev/null<br>&gt; &gt; @@ -1,23 +0,0 @@<br>&gt; &g=
t; -/* SPDX-License-Identifier: BSD-3-Clause<br>&gt; &gt; - * Copyright(c) =
2019-2023 Broadcom<br>&gt; &gt; - * All rights reserved.<br>&gt; &gt; - */<=
br>&gt; &gt; -<br>&gt; &gt; -#include &lt;string.h&gt;<br>&gt; &gt; -#inclu=
de &lt;math.h&gt;<br>&gt; &gt; -#include &lt;sys/param.h&gt;<br>&gt; &gt; -=
#include &lt;rte_common.h&gt;<br>&gt; &gt; -#include &lt;rte_errno.h&gt;<br=
>&gt; &gt; -#include &lt;rte_log.h&gt;<br>&gt; &gt; -#include &quot;tf_core=
.h&quot;<br>&gt; &gt; -#include &quot;tf_util.h&quot;<br>&gt; &gt; -#includ=
e &quot;tf_common.h&quot;<br>&gt; &gt; -#include &quot;tf_em.h&quot;<br>&gt=
; &gt; -#include &quot;tf_em_common.h&quot;<br>&gt; &gt; -#include &quot;tf=
_msg.h&quot;<br>&gt; &gt; -#include &quot;tfp.h&quot;<br>&gt; &gt; -#includ=
e &quot;tf_device.h&quot;<br>&gt; &gt; -#include &quot;tf_ext_flow_handle.h=
&quot;<br>&gt; &gt; -#include &quot;hcapi_cfa.h&quot;<br>&gt; &gt; -#includ=
e &quot;bnxt.h&quot;<br>&gt; &gt; -<br>&gt; &gt; diff --git a/drivers/net/b=
nxt/tf_core/tf_em_host.c b/drivers/net/bnxt/tf_core/tf_em_host.c<br>&gt; &g=
t; deleted file mode 100644<br>&gt; &gt; index 6db0057b2c..0000000000<br>&g=
t; &gt; --- a/drivers/net/bnxt/tf_core/tf_em_host.c<br>&gt; &gt; +++ /dev/n=
ull<br>&gt; &gt; @@ -1,23 +0,0 @@<br>&gt; &gt; -/* SPDX-License-Identifier:=
 BSD-3-Clause<br>&gt; &gt; - * Copyright(c) 2019-2023 Broadcom<br>&gt; &gt;=
 - * All rights reserved.<br>&gt; &gt; - */<br>&gt; &gt; -<br>&gt; &gt; -#i=
nclude &lt;string.h&gt;<br>&gt; &gt; -#include &lt;math.h&gt;<br>&gt; &gt; =
-#include &lt;sys/param.h&gt;<br>&gt; &gt; -#include &lt;rte_common.h&gt;<b=
r>&gt; &gt; -#include &lt;rte_errno.h&gt;<br>&gt; &gt; -#include &lt;rte_lo=
g.h&gt;<br>&gt; &gt; -<br>&gt; &gt; -#include &quot;tf_core.h&quot;<br>&gt;=
 &gt; -#include &quot;tf_util.h&quot;<br>&gt; &gt; -#include &quot;tf_commo=
n.h&quot;<br>&gt; &gt; -#include &quot;tf_em.h&quot;<br>&gt; &gt; -#include=
 &quot;tf_em_common.h&quot;<br>&gt; &gt; -#include &quot;tf_msg.h&quot;<br>=
&gt; &gt; -#include &quot;tfp.h&quot;<br>&gt; &gt; -#include &quot;lookup3.=
h&quot;<br>&gt; &gt; -#include &quot;tf_ext_flow_handle.h&quot;<br>&gt; &gt=
; -<br>&gt; &gt; -#include &quot;bnxt.h&quot;<br>&gt; &gt; diff --git a/dri=
vers/net/bnxt/tf_ulp/ulp_utils.c b/drivers/net/bnxt/tf_ulp/ulp_utils.c<br>&=
gt; &gt; deleted file mode 100644<br>&gt; &gt; index 85e309d7a2..0000000000=
<br>&gt; &gt; --- a/drivers/net/bnxt/tf_ulp/ulp_utils.c<br>&gt; &gt; +++ /d=
ev/null<br>&gt; &gt; @@ -1,1100 +0,0 @@<br>&gt; &gt; -/* SPDX-License-Ident=
ifier: BSD-3-Clause<br>&gt; &gt; - * Copyright(c) 2014-2023 Broadcom<br>&gt=
; &gt; - * All rights reserved.<br>&gt; &gt; - */<br>&gt; &gt; -<br>&gt; &g=
t; -#include &lt;rte_common.h&gt;<br>&gt; &gt; -#include &quot;ulp_utils.h&=
quot;<br>&gt; &gt; -#include &quot;bnxt_tf_common.h&quot;<br>&gt; &gt; -<br=
>&gt; &gt; -/*<br>&gt; &gt; - * Initialize the regfile structure for writin=
g<br>&gt; &gt; - *<br>&gt; &gt; - * regfile [in] Ptr to a regfile instance<=
br>&gt; &gt; - *<br>&gt; &gt; - * returns zero on success<br>&gt; &gt; - */=
<br>&gt; &gt; -int32_t<br>&gt; &gt; -ulp_regfile_init(struct ulp_regfile *r=
egfile)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 /* validate the=
 arguments */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (!regfile) {<br>&gt; &=
gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &q=
uot;invalid argument\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<=
br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 memset(regfile, 0, sizeof(struct ulp_re=
gfile));<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return 0; /* Success */<br>&gt=
; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/*<br>&gt; &gt; - * Read a value fro=
m the regfile<br>&gt; &gt; - *<br>&gt; &gt; - * regfile [in] The regfile in=
stance. Must be initialized prior to being used<br>&gt; &gt; - *<br>&gt; &g=
t; - * field [in] The field to be read within the regfile.<br>&gt; &gt; - *=
<br>&gt; &gt; - * data [in/out]<br>&gt; &gt; - *<br>&gt; &gt; - * returns z=
ero on success<br>&gt; &gt; - */<br>&gt; &gt; -int32_t<br>&gt; &gt; -ulp_re=
gfile_read(struct ulp_regfile *regfile,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum bnxt_ulp_rf_idx field,<br>&gt; &gt;=
 - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *data)<b=
r>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 /* validate the argument=
s */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (!regfile || field &gt;=3D BNXT=
_ULP_RF_IDX_LAST) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quot;invalid argument\n&quot;);<br>&gt; &gt; =
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>&gt; =
&gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 *data =3D regfile-&gt;entry[field].data;<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 return 0;<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/*<br>&gt=
; &gt; - * Write a value to the regfile<br>&gt; &gt; - *<br>&gt; &gt; - * r=
egfile [in] The regfile instance.=C2=A0 Must be initialized prior to being =
used<br>&gt; &gt; - *<br>&gt; &gt; - * field [in] The field to be written w=
ithin the regfile.<br>&gt; &gt; - *<br>&gt; &gt; - * data [in] The value is=
 written into this variable.=C2=A0 It is going to be in the<br>&gt; &gt; - =
* same byte order as it was written.<br>&gt; &gt; - *<br>&gt; &gt; - * size=
 [in] The size in bytes of the value being written into this<br>&gt; &gt; -=
 * variable.<br>&gt; &gt; - *<br>&gt; &gt; - * returns 0 on success<br>&gt;=
 &gt; - */<br>&gt; &gt; -int32_t<br>&gt; &gt; -ulp_regfile_write(struct ulp=
_regfile *regfile,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 enum bnxt_ulp_rf_idx field,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t data)<br>&gt; &gt; -{<br>&g=
t; &gt; - =C2=A0 =C2=A0 =C2=A0 /* validate the arguments */<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 if (!regfile || field &gt;=3D BNXT_ULP_RF_IDX_LAST) {<=
br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DB=
G(ERR, &quot;invalid argument\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL; /* failure */<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 r=
egfile-&gt;entry[field].data =3D data;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
return 0; /* Success */<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -static=
 void<br>&gt; &gt; -ulp_bs_put_msb(uint8_t *bs, uint16_t bitpos, uint8_t bi=
tlen, uint8_t val)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint=
8_t bitoffs =3D bitpos % 8;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint16_t in=
dex =C2=A0=3D bitpos / 8;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint8_t mask;=
<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint8_t tmp;<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 int8_t shift;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0=
 tmp =3D bs[index];<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 mask =3D ((uint8_t)=
-1 &gt;&gt; (8 - bitlen));<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 shift =3D 8 =
- bitoffs - bitlen;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 val &amp;=3D mask;<=
br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (shift &gt;=3D 0) {<b=
r>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp &amp;=3D=
 ~(mask &lt;&lt; shift);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 tmp |=3D val &lt;&lt; shift;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bs[index] =3D tmp;<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 } else {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 tmp &amp;=3D ~((uint8_t)-1 &gt;&gt; bitoffs);<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp |=3D val &gt;&gt; -shi=
ft;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bs[inde=
x++] =3D tmp;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tmp =3D bs[index];<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp &amp;=3D ((uint8_t)-1 &gt;&gt; (bitlen - (8=
 - bitoffs)));<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tmp |=3D val &lt;&lt; (8 + shift);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bs[index] =3D tmp;<br>&gt; &gt; - =C2=A0 =C2=A0=
 =C2=A0 }<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -static void<br>&gt; =
&gt; -ulp_bs_put_lsb(uint8_t *bs, uint16_t bitpos, uint8_t bitlen, uint8_t =
val)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint8_t bitoffs =
=3D bitpos % 8;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint16_t index =C2=A0=
=3D bitpos / 8;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint8_t mask;<br>&gt; &=
gt; - =C2=A0 =C2=A0 =C2=A0 uint8_t tmp;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0=
 uint8_t shift;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint8_t partial;<br>&gt=
; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 tmp =3D bs[index];<br>&gt; &gt=
; - =C2=A0 =C2=A0 =C2=A0 shift =3D bitoffs;<br>&gt; &gt; -<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 if (bitoffs + bitlen &lt;=3D 8) {<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D ((1 &lt;&lt; bitlen)=
 - 1) &lt;&lt; shift;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tmp &amp;=3D ~mask;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 tmp |=3D ((val &lt;&lt; shift) &amp; mask);<br>&gt; &g=
t; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bs[index] =3D tmp;<br=
>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 } else {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 partial =3D 8 - bitoffs;<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D ((1 &lt;&lt; partial=
) - 1) &lt;&lt; shift;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 tmp &amp;=3D ~mask;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 tmp |=3D ((val &lt;&lt; shift) &amp; mask);<br>&gt=
; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bs[index++] =3D t=
mp;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 val &gt;&gt;=3D partial;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 partial =3D bitlen - partial;<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D ((1 &lt;&lt; partial) - =
1);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D=
 bs[index];<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 tmp &amp;=3D ~mask;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tmp |=3D (val &amp; mask);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bs[index] =3D tmp;<br>&gt; &gt; - =C2=A0 =C2=A0=
 =C2=A0 }<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/*<br>&gt; &gt; - * =
Add data to the byte array in Little endian format.<br>&gt; &gt; - *<br>&gt=
; &gt; - * bs [in] The byte array where data is pushed<br>&gt; &gt; - *<br>=
&gt; &gt; - * pos [in] The offset where data is pushed<br>&gt; &gt; - *<br>=
&gt; &gt; - * len [in] The number of bits to be added to the data array.<br=
>&gt; &gt; - *<br>&gt; &gt; - * val [in] The data to be added to the data a=
rray.<br>&gt; &gt; - *<br>&gt; &gt; - * returns the number of bits pushed.<=
br>&gt; &gt; - */<br>&gt; &gt; -uint32_t<br>&gt; &gt; -ulp_bs_push_lsb(uint=
8_t *bs, uint16_t pos, uint8_t len, uint8_t *val)<br>&gt; &gt; -{<br>&gt; &=
gt; - =C2=A0 =C2=A0 =C2=A0 int i;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 int c=
nt =3D (len) / 8;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 int tlen =3D len;<br>=
&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (cnt &gt; 0 &amp;&amp; !=
(len % 8))<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
cnt -=3D 1;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 for (i =3D 0=
; i &lt; cnt; i++) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ulp_bs_put_lsb(bs, pos, 8, val[cnt - i]);<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pos +=3D 8;<br>&gt; &gt; - =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tlen -=3D 8;<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 /* H=
andle the remainder bits */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (tlen)<b=
r>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ulp_bs_put_l=
sb(bs, pos, tlen, val[0]);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return len;<=
br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/*<br>&gt; &gt; - * Add data t=
o the byte array in Big endian format.<br>&gt; &gt; - *<br>&gt; &gt; - * bs=
 [in] The byte array where data is pushed<br>&gt; &gt; - *<br>&gt; &gt; - *=
 pos [in] The offset where data is pushed<br>&gt; &gt; - *<br>&gt; &gt; - *=
 len [in] The number of bits to be added to the data array.<br>&gt; &gt; - =
*<br>&gt; &gt; - * val [in] The data to be added to the data array.<br>&gt;=
 &gt; - *<br>&gt; &gt; - * returns the number of bits pushed.<br>&gt; &gt; =
- */<br>&gt; &gt; -uint32_t<br>&gt; &gt; -ulp_bs_push_msb(uint8_t *bs, uint=
16_t pos, uint8_t len, uint8_t *val)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 int i;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 int cnt =3D (len +=
 7) / 8;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 /* Handle any r=
emainder bits */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 int tmp =3D len % 8;<b=
r>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (!tmp)<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D 8;<br>&gt; &gt; -<=
br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 ulp_bs_put_msb(bs, pos, tmp, val[0]);<b=
r>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 pos +=3D tmp;<br>&gt; &gt=
; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 for (i =3D 1; i &lt; cnt; i++) {<br=
>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ulp_bs_put_ms=
b(bs, pos, 8, val[i]);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 pos +=3D 8;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt=
; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return len;<br>&gt; &gt; -}<br>&gt;=
 &gt; -<br>&gt; &gt; -/*<br>&gt; &gt; - * Initializes the blob structure fo=
r creating binary blob<br>&gt; &gt; - *<br>&gt; &gt; - * blob [in] The blob=
 to be initialized<br>&gt; &gt; - *<br>&gt; &gt; - * bitlen [in] The bit le=
ngth of the blob<br>&gt; &gt; - *<br>&gt; &gt; - * order [in] The byte orde=
r for the blob.=C2=A0 Currently only supporting<br>&gt; &gt; - * big endian=
.=C2=A0 All fields are packed with this order.<br>&gt; &gt; - *<br>&gt; &gt=
; - * returns zero on success<br>&gt; &gt; - * Notes - If bitlen is zero th=
en set it to max.<br>&gt; &gt; - */<br>&gt; &gt; -int32_t<br>&gt; &gt; -ulp=
_blob_init(struct ulp_blob *blob,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint16_t bitlen,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 enum bnxt_ulp_byte_order order)<br>&gt; &gt; -{<br>&gt; &=
gt; - =C2=A0 =C2=A0 =C2=A0 /* validate the arguments */<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 if (!blob || bitlen &gt; (8 * sizeof(blob-&gt;data))) {<b=
r>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG=
(ERR, &quot;invalid argument\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (bitlen)<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blob-&gt;bitlen =3D bitlen;<b=
r>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 else<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blob-&gt;bitlen =3D BNXT_ULP_FLMP_BLOB_SIZE_IN=
_BITS;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 blob-&gt;byte_order =3D order;<b=
r>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 blob-&gt;write_idx =3D 0;<br>&gt; &gt; -=
 =C2=A0 =C2=A0 =C2=A0 memset(blob-&gt;data, 0, sizeof(blob-&gt;data));<br>&=
gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return 0; /* Success */<br>&gt; &gt; -}<br>=
&gt; &gt; -<br>&gt; &gt; -/*<br>&gt; &gt; - * Add data to the binary blob a=
t the current offset.<br>&gt; &gt; - *<br>&gt; &gt; - * blob [in] The blob =
that data is added to.=C2=A0 The blob must<br>&gt; &gt; - * be initialized =
prior to pushing data.<br>&gt; &gt; - *<br>&gt; &gt; - * data [in] A pointe=
r to bytes to be added to the blob.<br>&gt; &gt; - *<br>&gt; &gt; - * datal=
en [in] The number of bits to be added to the blob.<br>&gt; &gt; - *<br>&gt=
; &gt; - * The offset of the data is updated after each push of data.<br>&g=
t; &gt; - *<br>&gt; &gt; - * returns zero on success<br>&gt; &gt; - */<br>&=
gt; &gt; -#define ULP_BLOB_BYTE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08<br>&gt;=
 &gt; -#define ULP_BLOB_BYTE_HEX =C2=A0 =C2=A0 =C2=A00xFF<br>&gt; &gt; -#de=
fine BLOB_MASK_CAL(x) =C2=A0 =C2=A0 =C2=A0 ((0xFF &lt;&lt; (x)) &amp; 0xFF)=
<br>&gt; &gt; -int32_t<br>&gt; &gt; -ulp_blob_push(struct ulp_blob *blob,<b=
r>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t *data,<br>&=
gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t datalen)<br>&=
gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint32_t rc;<br>&gt; &gt; -=
<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 /* validate the arguments */<br>&gt; &=
gt; - =C2=A0 =C2=A0 =C2=A0 if (!blob || datalen &gt; (uint32_t)(blob-&gt;bi=
tlen - blob-&gt;write_idx)) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quot;invalid argument\n&quot;);<br>=
&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL=
;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 if (blob-&gt;byte_order =3D=3D BNXT_ULP_BYTE_ORDER_BE)<br=
>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D ulp_bs=
_push_msb(blob-&gt;data,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0blob-&gt;write_idx,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0datalen,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 e=
lse<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D =
ulp_bs_push_lsb(blob-&gt;data,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0blob-&gt;write_idx,<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0datalen,<br>&gt; &gt; - =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data);<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 if (!rc) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 BNXT_DRV_DBG(ERR, &quot;Failed to write blob\n&quot;);<br>&gt; &gt; =
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>&gt; =
&gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 blob-&gt;=
write_idx +=3D datalen;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return 0;<br>&g=
t; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/*<br>&gt; &gt; - * Insert data int=
o the binary blob at the given offset.<br>&gt; &gt; - *<br>&gt; &gt; - * bl=
ob [in] The blob that data is added to.=C2=A0 The blob must<br>&gt; &gt; - =
* be initialized prior to pushing data.<br>&gt; &gt; - *<br>&gt; &gt; - * o=
ffset [in] The offset where the data needs to be inserted.<br>&gt; &gt; - *=
<br>&gt; &gt; - * data [in/out] A pointer to bytes to be added to the blob.=
<br>&gt; &gt; - *<br>&gt; &gt; - * datalen [in] The number of bits to be ad=
ded to the blob.<br>&gt; &gt; - *<br>&gt; &gt; - * The offset of the data i=
s updated after each push of data.<br>&gt; &gt; - *<br>&gt; &gt; - * return=
s zero on success<br>&gt; &gt; - */<br>&gt; &gt; -int32_t<br>&gt; &gt; -ulp=
_blob_insert(struct ulp_blob *blob, uint32_t offset,<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t *data, uint32_t datalen)<=
br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint32_t rc;<br>&gt; &g=
t; - =C2=A0 =C2=A0 =C2=A0 uint8_t local_data[BNXT_ULP_FLMP_BLOB_SIZE];<br>&=
gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint16_t mov_len;<br>&gt; &gt; -<br>&gt; &g=
t; - =C2=A0 =C2=A0 =C2=A0 /* validate the arguments */<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 if (!blob || datalen &gt; (uint32_t)(blob-&gt;bitlen - bl=
ob-&gt;write_idx) ||<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offs=
et &gt; blob-&gt;write_idx) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quot;invalid argument\n&quot;);<br>=
&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL=
;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 mov_len =3D blob-&gt;write_idx - offset;<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 /* If offset and data len are not 8 bit aligned then r=
eturn error */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (ULP_BITS_IS_BYTE_NOT=
_ALIGNED(offset) ||<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ULP_B=
ITS_IS_BYTE_NOT_ALIGNED(datalen)) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quot;invalid argument, not alig=
ned\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -EINVAL;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br=
>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 /* copy the data so we can move the data =
*/<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 memcpy(local_data, &amp;blob-&gt;dat=
a[ULP_BITS_2_BYTE_NR(offset)],<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ULP_BITS_2_BYTE(mov_len));<br>&gt; &gt; - =C2=A0 =C2=A0=
 =C2=A0 blob-&gt;write_idx =3D offset;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
if (blob-&gt;byte_order =3D=3D BNXT_ULP_BYTE_ORDER_BE)<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D ulp_bs_push_msb(blob-&=
gt;data,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0blob-&gt;write_idx,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0datalen,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0data);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 else<br>&gt; &g=
t; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D ulp_bs_push_ls=
b(blob-&gt;data,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0blob-&gt;write_idx,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0datalen,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0data);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (!rc)=
 {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV=
_DBG(ERR, &quot;Failed to write blob\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 /* copy the previously =
stored data */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;blob-&gt;dat=
a[ULP_BITS_2_BYTE_NR(offset + datalen)], local_data,<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ULP_BITS_2_BYTE(mov_len));<br>&gt;=
 &gt; - =C2=A0 =C2=A0 =C2=A0 blob-&gt;write_idx +=3D (mov_len + datalen);<b=
r>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return 0;<br>&gt; &gt; -}<br>&gt; &gt; -=
<br>&gt; &gt; -/*<br>&gt; &gt; - * Add data to the binary blob at the curre=
nt offset.<br>&gt; &gt; - *<br>&gt; &gt; - * blob [in] The blob that data i=
s added to.=C2=A0 The blob must<br>&gt; &gt; - * be initialized prior to pu=
shing data.<br>&gt; &gt; - *<br>&gt; &gt; - * data [in] 64-bit value to be =
added to the blob.<br>&gt; &gt; - *<br>&gt; &gt; - * datalen [in] The numbe=
r of bits to be added to the blob.<br>&gt; &gt; - *<br>&gt; &gt; - * The of=
fset of the data is updated after each push of data.<br>&gt; &gt; - * NULL =
returned on error, pointer pushed value otherwise.<br>&gt; &gt; - */<br>&gt=
; &gt; -uint8_t *<br>&gt; &gt; -ulp_blob_push_64(struct ulp_blob *blob,<br>=
&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t=
 *data,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint32_t datalen)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 ui=
nt8_t *val =3D (uint8_t *)data;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 int rc;=
<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 int size =3D (datalen +=
 7) / 8;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (!blob || !d=
ata ||<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 datalen &gt; (uint=
32_t)(blob-&gt;bitlen - blob-&gt;write_idx)) {<br>&gt; &gt; - =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quot;invalid argumen=
t\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return NULL;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; =
&gt; - =C2=A0 =C2=A0 =C2=A0 rc =3D ulp_blob_push(blob, &amp;val[8 - size], =
datalen);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (rc)<br>&gt; &gt; - =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>&gt; &gt; -<br>&=
gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return &amp;val[8 - size];<br>&gt; &gt; -}<=
br>&gt; &gt; -<br>&gt; &gt; -/*<br>&gt; &gt; - * Add data to the binary blo=
b at the current offset.<br>&gt; &gt; - *<br>&gt; &gt; - * blob [in] The bl=
ob that data is added to.=C2=A0 The blob must<br>&gt; &gt; - * be initializ=
ed prior to pushing data.<br>&gt; &gt; - *<br>&gt; &gt; - * data [in] 32-bi=
t value to be added to the blob.<br>&gt; &gt; - *<br>&gt; &gt; - * datalen =
[in] The number of bits to be added to the blob.<br>&gt; &gt; - *<br>&gt; &=
gt; - * The offset of the data is updated after each push of data.<br>&gt; =
&gt; - * NULL returned on error, pointer pushed value otherwise.<br>&gt; &g=
t; - */<br>&gt; &gt; -uint8_t *<br>&gt; &gt; -ulp_blob_push_32(struct ulp_b=
lob *blob,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0uint32_t *data,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0uint32_t datalen)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 uint8_t *val =3D (uint8_t *)data;<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 uint32_t rc;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint32_t size =
=3D ULP_BITS_2_BYTE(datalen);<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 if (!data || size &gt; sizeof(uint32_t)) {<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quot;invalid argu=
ment\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return NULL;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&g=
t; &gt; - =C2=A0 =C2=A0 =C2=A0 rc =3D ulp_blob_push(blob, &amp;val[sizeof(u=
int32_t) - size], datalen);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (rc)<br>=
&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<b=
r>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return &amp;val[sizeof(ui=
nt32_t) - size];<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/*<br>&gt; &g=
t; - * Add encap data to the binary blob at the current offset.<br>&gt; &gt=
; - *<br>&gt; &gt; - * blob [in] The blob that data is added to.=C2=A0 The =
blob must<br>&gt; &gt; - * be initialized prior to pushing data.<br>&gt; &g=
t; - *<br>&gt; &gt; - * data [in] value to be added to the blob.<br>&gt; &g=
t; - *<br>&gt; &gt; - * datalen [in] The number of bits to be added to the =
blob.<br>&gt; &gt; - *<br>&gt; &gt; - * The offset of the data is updated a=
fter each push of data.<br>&gt; &gt; - * NULL returned on error, pointer pu=
shed value otherwise.<br>&gt; &gt; - */<br>&gt; &gt; -int32_t<br>&gt; &gt; =
-ulp_blob_push_encap(struct ulp_blob *blob,<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t *data,<br>&gt; &gt=
; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t=
 datalen)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint8_t =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D (uint8_t *)data;<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 uint32_t =C2=A0 =C2=A0 =C2=A0 =C2=A0initial_size, write_size =
=3D datalen;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint32_t =C2=A0 =C2=A0 =C2=
=A0 =C2=A0size =3D 0;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if=
 (!blob || !data ||<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 datal=
en &gt; (uint32_t)(blob-&gt;bitlen - blob-&gt;write_idx)) {<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quot;in=
valid argument\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return -1;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt;=
 -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 initial_size =3D ULP_BYTE_2_BITS(siz=
eof(uint64_t)) -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (blob-&g=
t;write_idx % ULP_BYTE_2_BITS(sizeof(uint64_t)));<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 while (write_size &gt; 0) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (initial_size &amp;&amp; write_size &gt; ini=
tial_size) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D initial_size;<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i=
nitial_size =3D 0;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 } else if (initial_size &amp;&amp; write_size &lt;=3D initial_size)=
 {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 size =3D write_size;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initial_size =
=3D 0;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } el=
se if (write_size &gt; ULP_BYTE_2_BITS(sizeof(uint64_t))) {<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 size =3D ULP_BYTE_2_BITS(sizeof(uint64_t));<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D=
 write_size;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (u=
lp_blob_push(blob, val, size)) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quot;p=
ush field failed\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val +=3D ULP_BITS_2_BYTE(size);<br>&=
gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write_size -=3D=
 size;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 return datalen;<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/*<br>&=
gt; &gt; - * Adds pad to an initialized blob at the current offset<br>&gt; =
&gt; - *<br>&gt; &gt; - * blob [in] The blob that data is added to.=C2=A0 T=
he blob must<br>&gt; &gt; - * be initialized prior to pushing data.<br>&gt;=
 &gt; - *<br>&gt; &gt; - * datalen [in] The number of bits of pad to add<br=
>&gt; &gt; - *<br>&gt; &gt; - * returns the number of pad bits added, -1 on=
 failure<br>&gt; &gt; - */<br>&gt; &gt; -int32_t<br>&gt; &gt; -ulp_blob_pad=
_push(struct ulp_blob *blob,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t datalen)<br>&gt; &gt; -{<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 if (datalen &gt; (uint32_t)(blob-&gt;bitlen - blob-&gt=
;write_idx)) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 BNXT_DRV_DBG(ERR, &quot;Pad too large for blob\n&quot;);<br>&gt; &gt; -=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>&gt; &gt; -=
 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
blob-&gt;write_idx +=3D datalen;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return=
 datalen;<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/*<br>&gt; &gt; - * =
Adds pad to an initialized blob at the current offset based on<br>&gt; &gt;=
 - * the alignment.<br>&gt; &gt; - *<br>&gt; &gt; - * blob [in] The blob th=
at needs to be aligned<br>&gt; &gt; - *<br>&gt; &gt; - * align [in] Alignme=
nt in bits.<br>&gt; &gt; - *<br>&gt; &gt; - * returns the number of pad bit=
s added, -1 on failure<br>&gt; &gt; - */<br>&gt; &gt; -int32_t<br>&gt; &gt;=
 -ulp_blob_pad_align(struct ulp_blob *blob,<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t align)<br>&gt; &gt=
; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 int32_t pad =3D 0;<br>&gt; &gt; -<=
br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 pad =3D RTE_ALIGN(blob-&gt;write_idx, a=
lign) - blob-&gt;write_idx;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (pad &gt=
; (int32_t)(blob-&gt;bitlen - blob-&gt;write_idx)) {<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quot;Pad too l=
arge for blob\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return -1;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt;=
 - =C2=A0 =C2=A0 =C2=A0 blob-&gt;write_idx +=3D pad;<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 return pad;<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/* G=
et data from src and put into dst using little-endian format */<br>&gt; &gt=
; -static void<br>&gt; &gt; -ulp_bs_get_lsb(uint8_t *src, uint16_t bitpos, =
uint8_t bitlen, uint8_t *dst)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 uint8_t bitoffs =3D bitpos % ULP_BLOB_BYTE;<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 uint16_t index =C2=A0=3D ULP_BITS_2_BYTE_NR(bitpos);<br>&gt; =
&gt; - =C2=A0 =C2=A0 =C2=A0 uint8_t mask, partial, shift;<br>&gt; &gt; -<br=
>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 shift =3D bitoffs;<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 partial =3D ULP_BLOB_BYTE - bitoffs;<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 if (bitoffs + bitlen &lt;=3D ULP_BLOB_BYTE) {<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D ((1 &lt;&lt; bitl=
en) - 1) &lt;&lt; shift;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 *dst =3D (src[index] &amp; mask) &gt;&gt; shift;<br>&gt; &gt;=
 - =C2=A0 =C2=A0 =C2=A0 } else {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 mask =3D ((1 &lt;&lt; partial) - 1) &lt;&lt; shift;<b=
r>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *dst =3D (sr=
c[index] &amp; mask) &gt;&gt; shift;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 index++;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 partial =3D bitlen - partial;<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D ((1 &lt;&lt; part=
ial) - 1);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
*dst |=3D (src[index] &amp; mask) &lt;&lt; (ULP_BLOB_BYTE - bitoffs);<br>&g=
t; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt=
; -/*<br>&gt; &gt; - * Get data from the byte array in Little endian format=
.<br>&gt; &gt; - *<br>&gt; &gt; - * src [in] The byte array where data is e=
xtracted from<br>&gt; &gt; - *<br>&gt; &gt; - * dst [out] The byte array wh=
ere data is pulled into<br>&gt; &gt; - *<br>&gt; &gt; - * size [in] The siz=
e of dst array in bytes<br>&gt; &gt; - *<br>&gt; &gt; - * offset [in] The o=
ffset where data is pulled<br>&gt; &gt; - *<br>&gt; &gt; - * len [in] The n=
umber of bits to be extracted from the data array<br>&gt; &gt; - *<br>&gt; =
&gt; - * returns None.<br>&gt; &gt; - */<br>&gt; &gt; -void<br>&gt; &gt; -u=
lp_bs_pull_lsb(uint8_t *src, uint8_t *dst, uint32_t size,<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t offset, uint32_t =
len)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint32_t idx;<br>&=
gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint32_t cnt =3D ULP_BITS_2_BYTE_NR(len);<b=
r>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 /* iterate bytewise to ge=
t data */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 for (idx =3D 0; idx &lt; cnt;=
 idx++) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u=
lp_bs_get_lsb(src, offset, ULP_BLOB_BYTE,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&amp;dst[size - 1 - idx]);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offset +=3D ULP_BLOB_BYTE;<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len -=3D ULP_BLOB_BYTE;<br>&g=
t; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 /* Extract the last reminder data that is not 8 byte boundary */=
<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (len)<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ulp_bs_get_lsb(src, offset, len, &amp;ds=
t[size - 1 - idx]);<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/* Get dat=
a from src and put into dst using big-endian format */<br>&gt; &gt; -static=
 void<br>&gt; &gt; -ulp_bs_get_msb(uint8_t *src, uint16_t bitpos, uint8_t b=
itlen, uint8_t *dst)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 ui=
nt8_t bitoffs =3D bitpos % ULP_BLOB_BYTE;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 uint16_t index =C2=A0=3D ULP_BITS_2_BYTE_NR(bitpos);<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 uint8_t mask;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 int32_t=
 shift;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 shift =3D ULP_BL=
OB_BYTE - bitoffs - bitlen;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (shift &=
gt;=3D 0) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 mask =3D 0xFF &gt;&gt; -bitlen;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 *dst =3D (src[index] &gt;&gt; shift) &amp; mask;<br>&=
gt; &gt; - =C2=A0 =C2=A0 =C2=A0 } else {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *dst =3D (src[index] &amp; (0xFF &gt;&gt; b=
itoffs)) &lt;&lt; -shift;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 *dst |=3D src[index + 1] &gt;&gt; -shift;<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/*<br>&gt;=
 &gt; - * Get data from the byte array in Big endian format.<br>&gt; &gt; -=
 *<br>&gt; &gt; - * src [in] The byte array where data is extracted from<br=
>&gt; &gt; - *<br>&gt; &gt; - * dst [out] The byte array where data is pull=
ed into<br>&gt; &gt; - *<br>&gt; &gt; - * offset [in] The offset where data=
 is pulled<br>&gt; &gt; - *<br>&gt; &gt; - * len [in] The number of bits to=
 be extracted from the data array<br>&gt; &gt; - *<br>&gt; &gt; - * returns=
 None.<br>&gt; &gt; - */<br>&gt; &gt; -void<br>&gt; &gt; -ulp_bs_pull_msb(u=
int8_t *src, uint8_t *dst,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint32_t offset, uint32_t len)<br>&gt; &gt; -{<br>&gt; &g=
t; - =C2=A0 =C2=A0 =C2=A0 uint32_t idx;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0=
 uint32_t cnt =3D ULP_BITS_2_BYTE_NR(len);<br>&gt; &gt; -<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 /* iterate bytewise to get data */<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 for (idx =3D 0; idx &lt; cnt; idx++) {<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ulp_bs_get_msb(src, offset, U=
LP_BLOB_BYTE, &amp;dst[idx]);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 offset +=3D ULP_BLOB_BYTE;<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len -=3D ULP_BLOB_BYTE;<br>&gt; &gt;=
 - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 /* Extract the last reminder data that is not 8 byte boundary */<br>&gt=
; &gt; - =C2=A0 =C2=A0 =C2=A0 if (len)<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ulp_bs_get_msb(src, offset, len, &amp;dst[idx])=
;<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/*<br>&gt; &gt; - * Extract =
data from the binary blob using given offset.<br>&gt; &gt; - *<br>&gt; &gt;=
 - * blob [in] The blob that data is extracted from. The blob must<br>&gt; =
&gt; - * be initialized prior to pulling data.<br>&gt; &gt; - *<br>&gt; &gt=
; - * data [in] A pointer to put the data.<br>&gt; &gt; - * data_size [in] =
size of the data buffer in bytes.<br>&gt; &gt; - *offset [in] - Offset in t=
he blob to extract the data in bits format.<br>&gt; &gt; - * len [in] The n=
umber of bits to be pulled from the blob.<br>&gt; &gt; - *<br>&gt; &gt; - *=
 Output: zero on success, -1 on failure<br>&gt; &gt; - */<br>&gt; &gt; -int=
32_t<br>&gt; &gt; -ulp_blob_pull(struct ulp_blob *blob, uint8_t *data, uint=
32_t data_size,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ui=
nt16_t offset, uint16_t len)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 /* validate the arguments */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if =
(!blob || (offset + len) &gt; blob-&gt;bitlen ||<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ULP_BYTE_2_BITS(data_size) &lt; len) {<br>&gt; &gt=
; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quo=
t;invalid argument\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 return -1; /* failure */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (blob-&gt;byte_=
order =3D=3D BNXT_ULP_BYTE_ORDER_BE)<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ulp_bs_pull_msb(blob-&gt;data, data, offset, le=
n);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 else<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ulp_bs_pull_lsb(blob-&gt;data, data, dat=
a_size, offset, len);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return 0;<br>&gt;=
 &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/*<br>&gt; &gt; - * Get the data port=
ion of the binary blob.<br>&gt; &gt; - *<br>&gt; &gt; - * blob [in] The blo=
b&#39;s data to be retrieved. The blob must be<br>&gt; &gt; - * initialized=
 prior to pushing data.<br>&gt; &gt; - *<br>&gt; &gt; - * datalen [out] The=
 number of bits that are filled.<br>&gt; &gt; - *<br>&gt; &gt; - * Returns =
a byte array of the blob data or NULL on error.<br>&gt; &gt; - */<br>&gt; &=
gt; -uint8_t *<br>&gt; &gt; -ulp_blob_data_get(struct ulp_blob *blob,<br>&g=
t; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t =
*datalen)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 /* validate t=
he arguments */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (!blob) {<br>&gt; &g=
t; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &qu=
ot;invalid argument\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return NULL; /* failure */<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 *datalen =3D blob-&gt;writ=
e_idx;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return blob-&gt;data;<br>&gt; &g=
t; -}<br>&gt; &gt; -<br>&gt; &gt; -/*<br>&gt; &gt; - * Get the data length =
of the binary blob.<br>&gt; &gt; - *<br>&gt; &gt; - * blob [in] The blob&#3=
9;s data len to be retrieved.<br>&gt; &gt; - *<br>&gt; &gt; - * returns len=
gth of the binary blob<br>&gt; &gt; - */<br>&gt; &gt; -uint16_t<br>&gt; &gt=
; -ulp_blob_data_len_get(struct ulp_blob *blob)<br>&gt; &gt; -{<br>&gt; &gt=
; - =C2=A0 =C2=A0 =C2=A0 /* validate the arguments */<br>&gt; &gt; - =C2=A0=
 =C2=A0 =C2=A0 if (!blob) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quot;invalid argument\n&quot;);<br>&gt=
; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0; /* fail=
ure */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 return blob-&gt;write_idx;<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &g=
t; -/*<br>&gt; &gt; - * Set the encap swap start index of the binary blob.<=
br>&gt; &gt; - *<br>&gt; &gt; - * blob [in] The blob&#39;s data to be retri=
eved. The blob must be<br>&gt; &gt; - * initialized prior to pushing data.<=
br>&gt; &gt; - *<br>&gt; &gt; - * returns void.<br>&gt; &gt; - */<br>&gt; &=
gt; -void<br>&gt; &gt; -ulp_blob_encap_swap_idx_set(struct ulp_blob *blob)<=
br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 /* validate the argumen=
ts */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (!blob) {<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quot;inval=
id argument\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return; /* failure */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&=
gt; &gt; - =C2=A0 =C2=A0 =C2=A0 blob-&gt;encap_swap_idx =3D blob-&gt;write_=
idx;<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/*<br>&gt; &gt; - * Perfo=
rm the encap buffer swap to 64 bit reversal.<br>&gt; &gt; - *<br>&gt; &gt; =
- * blob [in] The blob&#39;s data to be used for swap.<br>&gt; &gt; - *<br>=
&gt; &gt; - * returns void.<br>&gt; &gt; - */<br>&gt; &gt; -void<br>&gt; &g=
t; -ulp_blob_perform_encap_swap(struct ulp_blob *blob)<br>&gt; &gt; -{<br>&=
gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint32_t i, idx =3D 0, end_idx =3D 0, round=
off;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint8_t temp_val_1, temp_val_2;<br=
>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 /* validate the arguments =
*/<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (!blob) {<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quot;invalid a=
rgument\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return; /* failure */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; =
&gt; - =C2=A0 =C2=A0 =C2=A0 idx =3D ULP_BITS_2_BYTE_NR(blob-&gt;encap_swap_=
idx);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 end_idx =3D ULP_BITS_2_BYTE(blob-=
&gt;write_idx);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 roundoff =3D ULP_BYTE_2=
_BITS(ULP_BITS_2_BYTE(end_idx));<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (ro=
undoff &gt; end_idx) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 blob-&gt;write_idx +=3D ULP_BYTE_2_BITS(roundoff - end_idx);<=
br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 end_idx =3D=
 roundoff;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 while (idx &lt;=3D end_idx) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; 4; i =3D i + 2) {<br>&=
gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 temp_val_1 =3D blob-&gt;data[idx + i];<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 temp_=
val_2 =3D blob-&gt;data[idx + i + 1];<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blob-&gt;data[idx +=
 i] =3D blob-&gt;data[idx + 6 - i];<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blob-&gt;data[idx + i =
+ 1] =3D blob-&gt;data[idx + 7 - i];<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blob-&gt;data[idx +=
 7 - i] =3D temp_val_2;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blob-&gt;data[idx + 6 - i] =3D te=
mp_val_1;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }=
<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 idx +=3D 8=
;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -}<br>&gt; &gt; -<br>&=
gt; &gt; -/*<br>&gt; &gt; - * Perform the blob buffer reversal byte wise.<b=
r>&gt; &gt; - * This api makes the first byte the last and<br>&gt; &gt; - *=
 vice-versa.<br>&gt; &gt; - *<br>&gt; &gt; - * blob [in] The blob&#39;s dat=
a to be used for swap.<br>&gt; &gt; - * chunk_size[in] the swap is done wit=
hin the chunk in bytes<br>&gt; &gt; - *<br>&gt; &gt; - * returns void.<br>&=
gt; &gt; - */<br>&gt; &gt; -void<br>&gt; &gt; -ulp_blob_perform_byte_revers=
e(struct ulp_blob *blob,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t chu=
nk_size)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint32_t idx =
=3D 0, jdx =3D 0, num =3D 0;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint8_t xc=
har;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint8_t *buff;<br>&gt; &gt; -<br>&=
gt; &gt; - =C2=A0 =C2=A0 =C2=A0 /* validate the arguments */<br>&gt; &gt; -=
 =C2=A0 =C2=A0 =C2=A0 if (!blob) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quot;invalid argument\n&quot;);=
<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return; /*=
 failure */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &g=
t; - =C2=A0 =C2=A0 =C2=A0 buff =3D blob-&gt;data;<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 num =3D ULP_BITS_2_BYTE(blob-&gt;write_idx) / chunk_size;<br>&gt=
; &gt; - =C2=A0 =C2=A0 =C2=A0 for (idx =3D 0; idx &lt; num; idx++) {<br>&gt=
; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (jdx =3D 0; j=
dx &lt; chunk_size / 2; jdx++) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xchar =3D buff[jdx];<br>&=
gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 buff[jdx] =3D buff[(chunk_size - 1) - jdx];<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 buff[(chunk_size - 1) - jdx] =3D xchar;<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 buff +=3D chunk_size;<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 }<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/*<br>&gt; &gt; -=
 * Perform the blob buffer 64 bit word swap.<br>&gt; &gt; - * This api make=
s the first 4 bytes the last in<br>&gt; &gt; - * a given 64 bit value and v=
ice-versa.<br>&gt; &gt; - *<br>&gt; &gt; - * blob [in] The blob&#39;s data =
to be used for swap.<br>&gt; &gt; - *<br>&gt; &gt; - * returns void.<br>&gt=
; &gt; - */<br>&gt; &gt; -void<br>&gt; &gt; -ulp_blob_perform_64B_word_swap=
(struct ulp_blob *blob)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0=
 uint32_t i, j, num;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint8_t xchar;<br>=
&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint32_t word_size =3D ULP_64B_IN_BYTES / =
2;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 /* validate the argum=
ents */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (!blob) {<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quot;inval=
id argument\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return; /* failure */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&=
gt; &gt; - =C2=A0 =C2=A0 =C2=A0 num =3D ULP_BITS_2_BYTE(blob-&gt;write_idx)=
;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; num; i =3D i + U=
LP_64B_IN_BYTES) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 for (j =3D 0; j &lt; word_size; j++) {<br>&gt; &gt; - =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xchar =3D b=
lob-&gt;data[i + j];<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blob-&gt;data[i + j] =3D blob-&gt;da=
ta[i + j + word_size];<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blob-&gt;data[i + j + word_size] =
=3D xchar;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
}<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -}<br>&gt; &gt; -<br>&=
gt; &gt; -/*<br>&gt; &gt; - * Perform the blob buffer 64 bit byte swap.<br>=
&gt; &gt; - * This api makes the first byte the last in<br>&gt; &gt; - * a =
given 64 bit value and vice-versa.<br>&gt; &gt; - *<br>&gt; &gt; - * blob [=
in] The blob&#39;s data to be used for swap.<br>&gt; &gt; - *<br>&gt; &gt; =
- * returns void.<br>&gt; &gt; - */<br>&gt; &gt; -void<br>&gt; &gt; -ulp_bl=
ob_perform_64B_byte_swap(struct ulp_blob *blob)<br>&gt; &gt; -{<br>&gt; &gt=
; - =C2=A0 =C2=A0 =C2=A0 uint32_t i, j, num;<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 uint8_t xchar;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint32_t offset =
=3D ULP_64B_IN_BYTES - 1;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 /* validate the arguments */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (!b=
lob) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT=
_DRV_DBG(ERR, &quot;invalid argument\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return; /* failure */<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 num =3D ULP_BITS=
_2_BYTE(blob-&gt;write_idx);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 for (i =3D=
 0; i &lt; num; i =3D i + ULP_64B_IN_BYTES) {<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &lt; (ULP_64B_IN_BYTES /=
 2); j++) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xchar =3D blob-&gt;data[i + j];<br>&gt; &gt; -=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 blob-&gt;data[i + j] =3D blob-&gt;data[i + offset - j];<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 blob-&gt;data[i + offset - j] =3D xchar;<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<=
br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -static int32_t<br>&gt; &gt; -u=
lp_blob_msb_block_merge(struct ulp_blob *dst, struct ulp_blob *src,<br>&gt;=
 &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0uint32_t block_size, uint32_t pad)<br>&gt; &gt; -{<br>&gt;=
 &gt; - =C2=A0 =C2=A0 =C2=A0 uint32_t i, k, write_bytes, remaining;<br>&gt;=
 &gt; - =C2=A0 =C2=A0 =C2=A0 uint16_t num;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 uint8_t *src_buf =3D ulp_blob_data_get(src, &amp;num);<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 uint8_t bluff;<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 for (i =3D 0; i &lt; num;) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (((dst-&gt;write_idx % block_size) + (nu=
m - i)) &gt; block_size)<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write_bytes =3D block_size -<br>&=
gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (dst-&gt;write_idx % block_size);=
<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>&g=
t; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 write_bytes =3D num - i;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (k =3D 0; k &lt; ULP_BITS_2_BYTE_NR(write_b=
ytes); k++) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ulp_bs_put_msb(dst-&gt;data, dst-&gt;write_=
idx, ULP_BLOB_BYTE,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0*src_buf);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dst-&gt;write_idx +=3D ULP=
_BLOB_BYTE;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 src_buf++;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 remaining =3D write_bytes % ULP_BLOB_BYTE;<br>&gt; &gt=
; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (remaining) {<br>&g=
t; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 bluff =3D (*src_buf) &amp; ((uint8_t)-1 &lt;&lt;<br>&gt; &gt;=
 - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (ULP_BLOB_BYTE - remaining));<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ulp_bs_put_msb(=
dst-&gt;data, dst-&gt;write_idx,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ULP_BLOB_BYTE, bluff);<br>&gt; &gt; - =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dst-=
&gt;write_idx +=3D remaining;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (write_bytes !=3D (num - i)) {<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* add t=
he padding */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ulp_blob_pad_push(dst, pad);<br>&gt; &gt; -=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (remaining) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ulp_bs_p=
ut_msb(dst-&gt;data, dst-&gt;write_idx,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ULP_BLOB_=
BYTE - remaining,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*src_buf);<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dst-&gt;write_idx +=3D ULP_BLOB_BYTE - remainin=
g;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 src_buf++;<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=
&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i +=3D write_b=
ytes;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 return 0;<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/*<br>&gt; &g=
t; - * Perform the blob buffer merge.<br>&gt; &gt; - * This api makes the s=
rc blob merged to the dst blob.<br>&gt; &gt; - * The block size and pad siz=
e help in padding the dst blob<br>&gt; &gt; - *<br>&gt; &gt; - * dst [in] T=
he destination blob, the blob to be merged.<br>&gt; &gt; - * src [in] The s=
rc blob.<br>&gt; &gt; - * block_size [in] The size of the block in bytes af=
ter which padding gets<br>&gt; &gt; - * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 applied.<br>&gt; &gt; - * pad [in] The size of the pad=
 to be applied.<br>&gt; &gt; - *<br>&gt; &gt; - * returns 0 on success.<br>=
&gt; &gt; - */<br>&gt; &gt; -int32_t<br>&gt; &gt; -ulp_blob_block_merge(str=
uct ulp_blob *dst, struct ulp_blob *src,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t block_size, ui=
nt32_t pad)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (dst-&gt=
;byte_order =3D=3D BNXT_ULP_BYTE_ORDER_BE &amp;&amp;<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 src-&gt;byte_order =3D=3D BNXT_ULP_BYTE_ORDER_B=
E)<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return u=
lp_blob_msb_block_merge(dst, src, block_size, pad);<br>&gt; &gt; -<br>&gt; =
&gt; - =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quot;block merge not impleme=
nted yet\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>&=
gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -int32_t<br>&gt; &gt; -ulp_blob_app=
end(struct ulp_blob *dst, struct ulp_blob *src,<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t src_offset, uint16_t src_le=
n)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint32_t k, remainin=
g =3D 0;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uint16_t num;<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 uint8_t bluff;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 uin=
t8_t *src_buf =3D ulp_blob_data_get(src, &amp;num);<br>&gt; &gt; -<br>&gt; =
&gt; - =C2=A0 =C2=A0 =C2=A0 if ((src_offset + src_len) &gt; num)<br>&gt; &g=
t; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>&g=
t; &gt; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 /* Only supporting BE for now=
 */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (src-&gt;byte_order !=3D BNXT_UL=
P_BYTE_ORDER_BE ||<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dst-&g=
t;byte_order !=3D BNXT_ULP_BYTE_ORDER_BE)<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>&gt; &gt; -<br>&gt; &gt;=
 - =C2=A0 =C2=A0 =C2=A0 /* Handle if the source offset is not on a byte bou=
ndary */<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 remaining =3D src_offset % ULP=
_BLOB_BYTE;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (remaining) {<br>&gt; &g=
t; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bluff =3D src_buf[src=
_offset / ULP_BLOB_BYTE] &amp; ((uint8_t)-1 &gt;&gt;<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ULP_BLOB_BYTE - remaining));=
<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ulp_bs_put=
_msb(dst-&gt;data, dst-&gt;write_idx,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ULP_BLOB_BYTE, bluff);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 dst-&gt;write_idx +=3D remaining;<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 src_offset +=3D remaining;<br=
>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 src_buf +=3D ULP_BITS_2_BYTE_NR(src_offset);<br>&gt; &gt; -<b=
r>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 /* Push the byte aligned pieces */<br>&g=
t; &gt; - =C2=A0 =C2=A0 =C2=A0 for (k =3D 0; k &lt; ULP_BITS_2_BYTE_NR(src_=
len); k++) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ulp_bs_put_msb(dst-&gt;data, dst-&gt;write_idx, ULP_BLOB_BYTE,<br>&gt; =
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*src_buf);<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dst-&gt;write_idx +=3D ULP_BLOB_BYTE=
;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 src_buf++=
;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; -<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 /* Handle the remaining if length is not a byte boundary =
*/<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (src_len &gt; remaining)<br>&gt; =
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remaining =3D (src_=
len - remaining) % ULP_BLOB_BYTE;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 else<=
br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remaining =
=3D 0;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if (remaining) {<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bluff =3D (*src_buf) &amp;=
 ((uint8_t)-1 &lt;&lt;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (ULP_BLOB_BYTE - remaining));<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ulp_bs_put_msb(dst-&gt;data, dst-&gt=
;write_idx,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ULP_BLOB_BYTE, bluf=
f);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dst-&gt=
;write_idx +=3D remaining;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &g=
t; -<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return 0;<br>&gt; &gt; -}<br>&gt; =
&gt; -<br>&gt; &gt; -/*<br>&gt; &gt; - * Perform the blob buffer copy.<br>&=
gt; &gt; - * This api makes the src blob merged to the dst blob.<br>&gt; &g=
t; - *<br>&gt; &gt; - * dst [in] The destination blob, the blob to be merge=
d.<br>&gt; &gt; - * src [in] The src blob.<br>&gt; &gt; - *<br>&gt; &gt; - =
* returns 0 on success.<br>&gt; &gt; - */<br>&gt; &gt; -int32_t<br>&gt; &gt=
; -ulp_blob_buffer_copy(struct ulp_blob *dst, struct ulp_blob *src)<br>&gt;=
 &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 if ((dst-&gt;write_idx + src-&=
gt;write_idx) &gt; dst-&gt;bitlen) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quot;source buffer too large=
\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
return -EINVAL;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0=
 =C2=A0 =C2=A0 if (ULP_BITS_IS_BYTE_NOT_ALIGNED(dst-&gt;write_idx) ||<br>&g=
t; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ULP_BITS_IS_BYTE_NOT_ALIGNED(s=
rc-&gt;write_idx)) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quot;source buffer is not aligned\n&quot;);<b=
r>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINV=
AL;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 memcpy(&amp;dst-&gt;data[ULP_BITS_2_BYTE_NR(dst-&gt;write_idx)],<br>&gt=
; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src-&gt;data, ULP_=
BITS_2_BYTE_NR(src-&gt;write_idx));<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 dst=
-&gt;write_idx +=3D src-&gt;write_idx;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
return 0;<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/*<br>&gt; &gt; - * =
Read data from the operand<br>&gt; &gt; - *<br>&gt; &gt; - * operand [in] A=
 pointer to a 16 Byte operand<br>&gt; &gt; - *<br>&gt; &gt; - * val [in/out=
] The variable to copy the operand to<br>&gt; &gt; - *<br>&gt; &gt; - * byt=
es [in] The number of bytes to read into val<br>&gt; &gt; - *<br>&gt; &gt; =
- * returns zero on success.<br>&gt; &gt; - */<br>&gt; &gt; -int32_t<br>&gt=
; &gt; -ulp_operand_read(uint8_t *operand,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *val,<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t bytes)<br>&gt; &gt=
; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 /* validate the arguments */<br>&g=
t; &gt; - =C2=A0 =C2=A0 =C2=A0 if (!operand || !val) {<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &quot;inval=
id argument\n&quot;);<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -EINVAL;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &g=
t; - =C2=A0 =C2=A0 =C2=A0 memcpy(val, operand, bytes);<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 return 0;<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/*=
<br>&gt; &gt; - * Check the buffer is empty<br>&gt; &gt; - *<br>&gt; &gt; -=
 * buf [in] The buffer<br>&gt; &gt; - * size [in] The size of the buffer<br=
>&gt; &gt; - *<br>&gt; &gt; - */<br>&gt; &gt; -int32_t ulp_buffer_is_empty(=
const uint8_t *buf, uint32_t size)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 return buf[0] =3D=3D 0 &amp;&amp; !memcmp(buf, buf + 1, size =
- 1);<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/* Function to check if =
bitmap is zero.Return 1 on success */<br>&gt; &gt; -uint32_t ulp_bitmap_is_=
zero(uint8_t *bitmap, int32_t size)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =
=C2=A0 =C2=A0 while (size-- &gt; 0) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*bitmap !=3D 0)<br>&gt; &gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0=
;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bitmap++;=
<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =
return 1;<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/* Function to check=
 if bitmap is ones. Return 1 on success */<br>&gt; &gt; -uint32_t ulp_bitma=
p_is_ones(uint8_t *bitmap, int32_t size)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 while (size-- &gt; 0) {<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*bitmap !=3D 0xFF)<br>&gt; &gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eturn 0;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bi=
tmap++;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =C2=A0 =C2=A0 =
=C2=A0 return 1;<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; -/* Function t=
o check if bitmap is not zero. Return 1 on success */<br>&gt; &gt; -uint32_=
t ulp_bitmap_notzero(const uint8_t *bitmap, int32_t size)<br>&gt; &gt; -{<b=
r>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 while (size-- &gt; 0) {<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*bitmap !=3D 0)<br>&gt=
; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return 1;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bitmap++;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; - =
=C2=A0 =C2=A0 =C2=A0 return 0;<br>&gt; &gt; -}<br>&gt; &gt; -<br>&gt; &gt; =
-/* returns 0 if input is power of 2 */<br>&gt; &gt; -int32_t ulp_util_is_p=
ower_of_2(uint64_t x)<br>&gt; &gt; -{<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 i=
f (((x - 1) &amp; x))<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -1;<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 return 0;<br>&gt;=
 &gt; -}<br>&gt; &gt; --<br>&gt; &gt; 2.51.0<br>&gt; &gt;</div></div>

--000000000000ec98e2064c293814--

--000000000000035515064c293929
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVcQYJKoZIhvcNAQcCoIIVYjCCFV4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLeMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGpzCCBI+g
AwIBAgIMTxuM8PbwRQIs9uJeMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTIxOFoXDTI3MDYyMTEzNTIxOFowgekxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzETMBEGA1UEBBMKUGFkbWFuYWJoYTEQMA4GA1UEKhMHS2lzaG9yZTEWMBQGA1UEChMNQlJP
QURDT00gSU5DLjEoMCYGA1UEAwwfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTEuMCwG
CSqGSIb3DQEJARYfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALtFWP+ax39qiJZsJuukdoqMyp0GWGaJ6MdaHvAxXWiEY5zmTiVU
QnpmNYp5SO1Cd1cBqDB0dcelQbiQ1qh+lnlUchJLR63y0ysUvUNvqV493q8+pHCm/2jPb0/R9rec
/jxwM9jaPAVkhGBwvudSfOAQlMPORtAHZyLHKFINcsNfLrGP/3lx+zj30v5tmDN7isOLWos7Jm/U
qRdC7UuUiXgX7q8xXd1MQlA95O73IY/Qb/y0ChEjGPb+U1wr+OsAWJ5fcjQXA/ffBb2GmMp9OUOs
wVNq8iHfie9nzNaaRw+yoyn0ovoiq2W3Q6r+U53ha/lz0itqCrJZN+G0MFf+cX8CAwEAAaOCAeMw
ggHfMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggr
BgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1l
Y2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2Ny
NnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGg
MgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5
LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWlt
ZWNhMjAyMy5jcmwwKgYDVR0RBCMwIYEfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTAT
BgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNV
HQ4EFgQURIyot+ZP/mdwQsofZexqAvOm5pMwDQYJKoZIhvcNAQELBQADggIBAKc5gYnhyTf+f6cm
kAHy1a4cLIWou43yaS+M/r69Pv44EVYvHxqt0mMvKh3U40Y+pHKph+VCjdoINKCd1SaqAFIqqEO4
XHWrFi3QAI3snUB6spPIoHN/srAcpX9tdrnAlyK593pq+H+mTMoFIGBP/oc8XCtaDgHp37rpuK9Q
qhF9h5cEJWgShmD7/Q02YydW3jsioy8HdTUD9fib1fRwiSc9uGq8JV5NJsYiJsi9FUz7kTUPohO0
h6U9tRUVmAf9gPbU46rin9By5X4Lt1jKge5O0vFEawCTr/pLmDcIf7CqRZfBoNalKOsBDovoeAOf
pXmQzQEMhnaf93MvbFvZaxC9Ir92DR45BH42xZuLKcQVUsqyLKwC6kEZg81AnZsRAUVpMvqiGbVb
hZnabsHragNY7Br3VCA2OaWk9yRRjt1UwzfIEEMNWqZeQzzAqKIR3XdXIrqAUlMQOX42tSV9FaIv
PSmR3uaH2M0/bRtz4TE1qRuTsLlr+XEGMxHssK7u7+WYM7EGF3ueZLcE7WmnwXEFli5Y5QX0SnmT
W8uDQvdvRdxXg4lkBLyifOudYTP3fULjpD6RWQPFlUPlh8F5QQEdKlfKW94rGD+O0u4sWi/msZw0
6VTvZ6C2BbUMJAo7coFff48NkW2xfICC8Kn1eU1eiWCrPSAls8STm9q25wOQMYICVzCCAlMCAQEw
YjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xv
YmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMTxuM8PbwRQIs9uJeMA0GCWCGSAFlAwQCAQUA
oIHHMC8GCSqGSIb3DQEJBDEiBCCbAGtg2e1N+sYea0Sg9j4BmkYBGnv0GjbbH0GlMRoZ0TAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMDQwMjAzMTRaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAx0ZHkA4iL
voeN7qeijm9w1HD2pxhnsyMU+xBN0R2BIzBPlFyiqUiujTTWgJViag+Q7A9jze/U32PEppNsZe1T
IOaX8WeXnxAtvjIVWAS5zjsDzgZ34owpW2EynwcVIIF+pFLwlAHAifbDbOB5g1UvpZTA7hPSdOsR
bJM22RooTWV3+aCyws2C4pCM0qWBbmWu1nBdrzi6L7he/XJizj9h+WkPIxSR+TPq0oFwVJ7CQNtF
u792zmhVDV7Qg+T5ieG38Lw5NukoTUJqqXVj9fDqUKXpYt3+kycxy7DkPSMgsJswID+T4VeuBaK0
Em0JY8Enrc5Sa0ftnPkNmLhJwnUN
--000000000000035515064c293929--
