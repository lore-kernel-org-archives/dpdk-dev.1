Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E16C982E3
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 17:54:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9311F42E88;
	Fri, 16 Jan 2026 18:54:04 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 31B6D4026A
 for <dev@dpdk.org>; Fri, 16 Jan 2026 18:54:03 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4801c1ad878so14567835e9.1
 for <dev@dpdk.org>; Fri, 16 Jan 2026 09:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768586042;
 x=1769190842; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iWu1O58imbSA2WOqnepPZNa1c+GSEKFr1wpz98jnCWA=;
 b=sFrWXMNmAObHlHShGQ/mF5Y0LX78UWUuwnIuX/7/n59lsn56+7eABMk/EgqMx0PyL3
 OoMykZxT9w4T0iQOMYdl+SUh+ae9A9wmFE8Mc2xJ3maVPstgPbJABhCRnDs4v9wA7/d/
 vT9c+qBL814hsVsW2uWFU5HgIlEX5PtJqeJn/+b5gpvjU2YC0sNhuZS32bAmRZkXnZF/
 vFIbYJO9VMWDM1uwHHEKxG39BM7TKKzpMFfmMTw232ZEXZgBGSx6mKQFQHoJy3DW0BiJ
 pXPwaH0AXsahryMSqQqeV1aqWsvkhQf5FlN5BjVkRlXg+YeplL5JHcmWOTD3eLFlJR1S
 1kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586043; x=1769190843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iWu1O58imbSA2WOqnepPZNa1c+GSEKFr1wpz98jnCWA=;
 b=enhHy6v9VZPPZErupArHqI1AVIZS3brKzK6DvfZffa5BeFGNuHxZQqp/02abzUlR4h
 J4sa/nTqH4DUjsSy6sxrR6a3CCCOXfvKyTavNDafzTbEM9UVMFD3DsxTjZ22AsfKfmH7
 YKf/c0DRzehITRsXlhybS9SdOn/xabwJCzmmRgc8NGSZysv/kqFzGIsAy1RfIzlDOmqs
 mr8CsN/bNBvGiuPcukdjRMvJS0E2rC/v+CM3uJmZAVLjYWDx4XQeVQp1GTdeIgLiuzC7
 hglJb91MDS52sk9E4fJ9NJH/NDlBxcrV+32Al8haQgD4Jz85LXc3GqCLSN/lwmGYPzw0
 qc0g==
X-Gm-Message-State: AOJu0YywlCFWq015GZrYLYC1VzZibV1uCpWnrOcY0kp6HDShYUmjwTxd
 nunS27lhg2whfjKV0YIq9E3DFqVigpTTkEzDn5RYPTh/OT4cuft9RLH09rIPnJfbwcxrbAM93ex
 3SyER
X-Gm-Gg: AY/fxX7nmPTSuKnLWdivFWWDz/WjfEOMrjppg96nhvd9puJADNThCuxl762SBFcKBRK
 aIMv9jZE3zECLcHqNRxhAXzq0nrBiNpFOKnzZ/HWHr3hW0L9xRlPy7iW9XzZ/UqcSEzVDcGtHBx
 yxLIN+efUZszavFxMr+gxhZ8rHwsoACpk3i+qCuyCIrW72UPDqACEQXtlCNCQdDKebUBs9G2NTn
 o4GdfF9c5FMhYlKvq/8kw5GNEKJJEq9fGeT4npaq2+XJVCpCHp5CDRpRhMnIdvP1Xcm/YIq/Bry
 gnDPsQMU1k8k9hhIdhw+sK7p5hhv/KkKLYqV3MLF1dZde5r5nXT3uwLgPz3Atv7Wk/l886th3qX
 fEoMRWSWaPr2XqcVmlNvlMV7Rxzu891mNOCGEFiw8kE+1ylhu8/jM04i1YVM3EXgIWhB8fID454
 DsuiVoaD6RsFwkzpWVPuDB7guNjkney/c6yJpufQFgQbGc0JjZDLjj
X-Received: by 2002:a05:600c:6309:b0:477:9cdb:e32e with SMTP id
 5b1f17b1804b1-4801e30d64dmr43530875e9.9.1768586042532; 
 Fri, 16 Jan 2026 09:54:02 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b2755absm138320745e9.15.2026.01.16.09.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:54:02 -0800 (PST)
Date: Fri, 16 Jan 2026 09:53:57 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: coolwilled <coolwilled@gmail.com>
Cc: dev@dpdk.org, users@dpdk.org
Subject: Re: Bug: crypto_snow3g failed in Auth snow3g + Cipher snow3g
Message-ID: <20260116095357.73f2705b@phoenix.local>
In-Reply-To: <CAL2ZP-A=cnXozqacMbDUKd15KgHifSmBjqNDN+o340yJ+3t99w@mail.gmail.com>
References: <CAL2ZP-A=cnXozqacMbDUKd15KgHifSmBjqNDN+o340yJ+3t99w@mail.gmail.com>
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

On Fri, 16 Jan 2026 18:45:15 +0800
coolwilled <coolwilled@gmail.com> wrote:

> Hi,
> I run "pdcp_autotest"  with --vdev=crypto_snow3g in app/dpdk-test in dpdk
> v25.11.
> When i = 42 in run_test_for_one_know_vec() in test_pdcp.c,
> It is PDCP control plane Auth snow3g gen + Cipher sonw3g enc,
> the case failed because the last 4 bytes is cleared in
> last for() loop in line 167 in  process_snow3g_cipher_op() in pmd_snow3g.c .
> 
> It can be fixed with following change:
> 
> diff --git a/drivers/crypto/ipsec_mb/pmd_snow3g.c
> b/drivers/crypto/ipsec_mb/pmd_snow3g.c
> index b3c3b05a8a..45a8be5fc8 100644
> --- a/drivers/crypto/ipsec_mb/pmd_snow3g.c
> +++ b/drivers/crypto/ipsec_mb/pmd_snow3g.c
> @@ -157,7 +157,7 @@ process_snow3g_cipher_op(struct ipsec_mb_qp *qp, struct
> rte_crypto_op **ops,
>         for (i = 0; i < num_ops; i++) {
>                 if ((session->op == IPSEC_MB_OP_HASH_VERIFY_THEN_DECRYPT ||
>                         session->op == IPSEC_MB_OP_HASH_GEN_THEN_ENCRYPT) &&
> -                               ops[i]->sym->m_dst != NULL) {
> +                               ops[i]->sym->m_dst != NULL &&
> ops[i]->sym->m_dst != ops[i]->sym->m_src) {
>                         digest_appended[i] =
>                                 snow3g_digest_appended_in_src(ops[i]);
>                         /* Clear unencrypted digest from

For a more complete idea of what is missing for a DPDK patch submission.
Here is the semi-automated AI patch review:

## Patch Review: crypto_snow3g Bug Report

This submission is **not a proper patch** - it's a bug report email with an embedded code suggestion. If the author wants this fix merged, they need to submit a formal patch. Here's my assessment against the AGENTS.md criteria:

---

### **ERRORS (Must Fix)**

| Issue | Details |
|-------|---------|
| **Missing Signed-off-by** | No `Signed-off-by:` tag present. Required for all patches. |
| **Invalid Subject Line Format** | `Bug: crypto_snow3g failed...` is a bug report title, not a commit subject. Should be: `crypto/snow3g: fix digest clear for in-place operations` or similar |
| **Wrong Component Prefix** | Uses `Bug:` instead of proper prefix like `crypto/snow3g:` |
| **Subject Line Too Long** | At 55 characters visible, but the full title would exceed 60 characters |
| **Incomplete Patch** | The diff is truncated - missing the context and the complete change |
| **Line Wrapping in Diff** | Lines 115-116 and 121-122 show improper line wrapping in the diff output itself |

---

### **WARNINGS (Should Fix)**

| Issue | Details |
|-------|---------|
| **Missing Fixes Tag** | If this fixes a regression, it should include `Fixes: <sha> ("original commit")` |
| **Missing Cc: stable@dpdk.org** | Bug fixes should typically be CC'd to stable |
| **No Bugzilla ID** | If there's a bugzilla entry, include `Bugzilla ID: NNNNN` |
| **Body starts informally** | Commit body should not read like an email; should describe the bug/fix concisely |

---

### **The Actual Code Change**

Looking at the suggested fix:
```c
-                               ops[i]->sym->m_dst != NULL) {
+                               ops[i]->sym->m_dst != NULL &&
+                               ops[i]->sym->m_dst != ops[i]->sym->m_src) {
```

The logic looks **correct** - it adds a check to avoid clearing the digest when the operation is in-place (src == dst). However:

1. **Line length**: Need to verify the continuation doesn't exceed 100 characters
2. **Explicit comparison style**: Using `!= NULL` is correct per DPDK style

---

### **Recommended Resubmission Format**

```
crypto/snow3g: fix digest clear for in-place cipher ops

When performing combined hash-then-encrypt operations with
in-place buffers (m_dst == m_src), the digest was incorrectly
being cleared. Add a check to skip clearing when source and
destination buffers are the same.

Fixes: <12-char-sha> ("original commit that introduced bug")
Cc: stable@dpdk.org

Signed-off-by: Real Name <email@domain.com>
---
 drivers/crypto/ipsec_mb/pmd_snow3g.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ipsec_mb/pmd_snow3g.c b/drivers/crypto/ipsec_mb/pmd_snow3g.c
index b3c3b05a8a..45a8be5fc8 100644
--- a/drivers/crypto/ipsec_mb/pmd_snow3g.c
+++ b/drivers/crypto/ipsec_mb/pmd_snow3g.c
@@ -157,7 +157,8 @@ process_snow3g_cipher_op(...)
 	for (i = 0; i < num_ops; i++) {
 		if ((session->op == IPSEC_MB_OP_HASH_VERIFY_THEN_DECRYPT ||
 		     session->op == IPSEC_MB_OP_HASH_GEN_THEN_ENCRYPT) &&
-		    ops[i]->sym->m_dst != NULL) {
+		    ops[i]->sym->m_dst != NULL &&
+		    ops[i]->sym->m_dst != ops[i]->sym->m_src) {
```

---

### **Summary**

| Severity | Count |
|----------|-------|
| **Error** | 6 |
| **Warning** | 4 |

**Verdict**: This is a valid bug report but not a submittable patch. The author should use `git format-patch` to create a proper patch with correct commit message format, sign-off, and complete diff context.
